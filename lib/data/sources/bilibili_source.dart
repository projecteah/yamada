import 'dart:math';

import 'package:dio/dio.dart';

import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/data/sources/base_source.dart';

class BilibiliSource implements SearchSource {
  static const String _apiBase = 'https://api.bilibili.com';
  static const String _searchApi = '$_apiBase/x/web-interface/search/type';
  static const String _fingerprintApi = '$_apiBase/x/frontend/finger/spi';

  static const String _defaultUserAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';

  final Dio _dio;
  late Options _searchOptions;
  String _browserCookie;

  BilibiliSource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: _apiBase,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 15),
              responseType: ResponseType.json,
              headers: {
                'User-Agent': _defaultUserAgent,
                'Referer': 'https://www.bilibili.com',
              },
            )),
        _browserCookie = '' {
    _browserCookie = _buildBrowserCookie(
      buvid3: _generateBuvid(),
      buvid4: _generateBuvid(),
    );
    _searchOptions = Options(headers: {
      'User-Agent': _defaultUserAgent,
      'Referer': 'https://search.bilibili.com',
      'Cookie': _browserCookie,
    });
  }

  @override
  StreamingPlatformId get sourceType => StreamingPlatformId.bilibili;

  String _generateBuvid() {
    final r = Random();
    String hex(int n) => List.generate(
        n, (_) => '0123456789ABCDEF'[r.nextInt(16)]).join();
    return '${hex(8)}-${hex(4)}-${hex(4)}-${hex(4)}-${hex(12)}';
  }

  String _buildBrowserCookie({required String buvid3, required String buvid4}) {
    final bNut = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return 'buvid3=$buvid3; buvid4=$buvid4; b_nut=$bNut; _uuid=$buvid3; buvid_fp=$buvid3';
  }

  String _mapOrder(SearchOrder order) {
    switch (order) {
      case SearchOrder.relevance:
        return 'totalrank';
      case SearchOrder.playCount:
        return 'click';
      case SearchOrder.publishDate:
        return 'pubdate';
    }
  }

  @override
  Future<SearchResult> search(
    String query, {
    int page = 1,
    int pageSize = 20,
    SearchOrder order = SearchOrder.relevance,
  }) async {
    try {
      var response = await _dio.get(
        _searchApi,
        queryParameters: {
          'keyword': query,
          'search_type': 'video',
          'page': page,
          'page_size': pageSize,
          'order': _mapOrder(order),
        },
        options: _searchOptions,
      );

      if (_isRiskControl(response.data)) {
        await _refreshFingerprint();
        response = await _dio.get(
          _searchApi,
          queryParameters: {
            'keyword': query,
            'search_type': 'video',
            'page': page,
            'page_size': pageSize,
            'order': _mapOrder(order),
          },
          options: _searchOptions,
        );
      }

      _checkResponse(response.data);

      final data = response.data['data'];
      final results = data['result'] as List? ?? [];
      final numResults = data['numResults'] as int? ?? 0;

      final tracks = results
          .whereType<Map>()
          .where((item) => item['bvid'] != null)
          .map((item) => Track(
                sourceId: item['bvid'] as String,
                sourceType: StreamingPlatformId.bilibili,
                title: _cleanHtml(item['title'] as String? ?? ''),
                artist: item['author'] as String?,
                durationMs: _parseDuration(item['duration'] as String? ?? '0:00'),
                thumbnailUrl: _fixImageUrl(item['pic'] as String?),
                viewCount: item['play'] as int?,
              ))
          .toList();

      return SearchResult(
        tracks: tracks,
        totalCount: numResults,
        page: page,
        pageSize: pageSize,
        hasMore: page * pageSize < numResults,
      );
    } on DioException catch (e) {
      throw _mapDioError(e);
    }
  }

  bool _isRiskControl(Object? data) => data is Map && data['code'] == -352;

  Future<void> _refreshFingerprint() async {
    final response = await _dio.get(_fingerprintApi);
    _checkResponse(response.data);
    final data = response.data['data'];
    if (data is! Map) return;
    final buvid3 = data['b_3'] as String?;
    final buvid4 = data['b_4'] as String?;
    if (buvid3 == null || buvid4 == null) return;
    _browserCookie = _buildBrowserCookie(buvid3: buvid3, buvid4: buvid4);
    _searchOptions = Options(headers: {
      'User-Agent': _defaultUserAgent,
      'Referer': 'https://search.bilibili.com',
      'Cookie': _browserCookie,
    });
  }

  void _checkResponse(Map<String, dynamic> data) {
    final code = data['code'];
    if (code != 0) {
      final message = data['message'] as String? ?? 'Unknown error';
      throw BilibiliApiException(code: code as int, message: message);
    }
  }

  BilibiliApiException _mapDioError(DioException e) {
    final status = e.response?.statusCode;
    if (e.type == DioExceptionType.badResponse) {
      return BilibiliApiException(
        code: -(status ?? 500),
        message: 'HTTP $status',
      );
    }
    return BilibiliApiException(
      code: e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout
          ? -1
          : -2,
      message: e.message ?? 'Network error',
    );
  }

  String _cleanHtml(String text) {
    return text
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&#39;', "'");
  }

  int _parseDuration(String duration) {
    final parts = duration.split(':');
    if (parts.length != 2) return 0;
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    return (minutes * 60 + seconds) * 1000;
  }

  String? _fixImageUrl(String? url) {
    if (url == null) return null;
    if (url.startsWith('//')) return 'https:$url';
    return url;
  }
}

class BilibiliApiException implements Exception {
  final int code;
  final String message;

  const BilibiliApiException({required this.code, required this.message});

  @override
  String toString() => 'BilibiliApiException($code): $message';
}
