import 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:yamada/data/sources/base_source.dart';
import 'package:yamada/models/audio_stream_model.dart';
import 'package:yamada/models/search_model.dart';
import 'package:yamada/models/streaming_platforms_model.dart';
import 'package:yamada/models/track_detail_model.dart';
import 'package:yamada/utils/format_util.dart';

class BilibiliSource
    implements SearchSource, TrackDetailSource, AudioStreamSource {
  BilibiliSource({Dio? dio, CookieJar? cookieJar})
      : _dio = dio ?? _createDio(cookieJar ?? CookieJar());

  static const String _apiBase = 'https://api.bilibili.com';
  static final Uri _apiUri = Uri.parse(_apiBase);
  static const String _searchApi = '/x/web-interface/search/type';
  static const String _viewApi = '/x/web-interface/view';
  static const String _playUrlApi = '/x/player/playurl';
  static const String _fingerprintApi = '/x/frontend/finger/spi';

  static const String _userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36';

  static const String _searchReferer = 'https://search.bilibili.com';
  static const String _siteReferer = 'https://www.bilibili.com';

  static const int _riskControlCode = -352;

  final Dio _dio;

  static Dio _createDio(CookieJar cookieJar) {
    final dio = Dio(BaseOptions(
      baseUrl: _apiBase,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
      headers: {
        'User-Agent': _userAgent,
        'Referer': _siteReferer,
      },
    ));
    dio.interceptors.add(_BilibiliInterceptor(dio, cookieJar));
    dio.interceptors.add(CookieManager(cookieJar));
    return dio;
  }

  @override
  String get name => 'Bilibili';

  Future<Response<Map<String, dynamic>>> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String referer = _siteReferer,
  }) async {
    try {
      return await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: {'Referer': referer}),
      );
    } on DioException catch (e) {
      throw _toSourceException(e);
    }
  }

  SourceException _toSourceException(DioException e) {
    final error = e.error;
    if (error is SourceException) return error;
    if (e.type == DioExceptionType.badResponse) {
      final status = e.response?.statusCode ?? 500;
      return SourceException(code: -status, message: 'HTTP $status');
    }
    final isTimeout = e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout;
    return SourceException(
      code: isTimeout ? -1 : -2,
      message: e.message ?? 'Network error',
    );
  }

  String _mapOrder(SearchOrder order) => switch (order) {
        SearchOrder.relevance => 'totalrank',
        SearchOrder.playCount => 'click',
        SearchOrder.publishDate => 'pubdate',
      };

  String? _fixImageUrl(String? url) {
    if (url == null) return null;
    return url.startsWith('//') ? 'https:$url' : url;
  }

  String _cleanHtml(String text) => text
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&#39;', "'");

  @override
  Future<SearchResult> search(
    String query, {
    int page = 1,
    int pageSize = 20,
    SearchOrder order = SearchOrder.relevance,
  }) async {
    final response = await _get(
      _searchApi,
      queryParameters: {
        'keyword': query,
        'search_type': 'video',
        'page': page,
        'page_size': pageSize,
        'order': _mapOrder(order),
      },
      referer: _searchReferer,
    );

    final data = response.data!['data'];
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
              durationMs:
                  parseDurationToMs(item['duration'] as String? ?? '0:00'),
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
  }

  Future<int> _resolveCid(String bvid, {int? cid}) async {
    if (cid != null) return cid;
    final response = await _get(_viewApi, queryParameters: {'bvid': bvid});
    final cidValue = response.data!['data']['cid'];
    if (cidValue == null) {
      throw const SourceException(code: -404, message: 'cid not found');
    }
    return cidValue as int;
  }

  @override
  Future<TrackDetail> getTrackDetail(String id, {int? cid}) async {
    final response = await _get(_viewApi, queryParameters: {'bvid': id});

    final data = response.data!['data'] as Map;
    final owner = data['owner'] as Map? ?? {};
    final pages = (data['pages'] as List? ?? [])
        .whereType<Map>()
        .map((p) => TrackPage(
              cid: p['cid'] as int,
              page: p['page'] as int,
              part: p['part'] as String? ?? 'P${p['page']}',
              duration: p['duration'] as int? ?? 0,
            ))
        .toList();

    return TrackDetail(
      sourceType: StreamingPlatformId.bilibili,
      sourceId: id,
      title: data['title'] as String? ?? '',
      description: data['desc'] as String? ?? '',
      coverUrl: _fixImageUrl(data['pic'] as String?),
      artist: owner['name'] as String?,
      durationMs: (data['duration'] as int? ?? 0) * 1000,
      cid: data['cid'] as int?,
      pages: pages,
    );
  }

  @override
  Future<AudioStream> getAudioStream(
    String id, {
    int? cid,
    AudioStreamFormat format = AudioStreamFormat.dash,
  }) async {
    final resolvedCid = await _resolveCid(id, cid: cid);
    final isDash = format == AudioStreamFormat.dash;
    final response = await _get(
      _playUrlApi,
      queryParameters: {
        'bvid': id,
        'cid': resolvedCid,
        'fnval': isDash ? 16 : 0,
        'qn': isDash ? 0 : 120,
        'fourk': 1,
      },
    );

    final data = response.data!['data'] as Map;

    if (isDash) {
      final dash = data['dash'] as Map?;
      final audios = (dash?['audio'] as List? ?? []).whereType<Map>().toList();
      if (audios.isEmpty) {
        throw const SourceException(
            code: -404, message: 'No audio stream available');
      }
      audios.sort(
          (a, b) => (b['bandwidth'] as int).compareTo(a['bandwidth'] as int));
      final selected = audios.first;
      return AudioStream(
        cid: resolvedCid,
        format: format,
        url: (selected['baseUrl'] ?? selected['base_url']) as String,
        bandwidth: selected['bandwidth'] as int,
        codec: selected['codecs'] as String?,
        backupUrls: ((selected['backupUrl'] ?? selected['backup_url']) as List?)
                ?.whereType<String>()
                .toList() ??
            const [],
        rawJson: response.data!,
      );
    }

    final durl = (data['durl'] as List? ?? []).whereType<Map>().toList();
    if (durl.isEmpty) {
      throw const SourceException(
          code: -404, message: 'No audio stream available');
    }
    final first = durl.first;
    return AudioStream(
      cid: resolvedCid,
      format: format,
      url: first['url'] as String,
      bandwidth: 0,
      rawJson: response.data!,
    );
  }
}

class _BilibiliInterceptor extends Interceptor {
  _BilibiliInterceptor(this._dio, this._cookieJar);

  final Dio _dio;
  final CookieJar _cookieJar;
  bool _seeded = false;

  static const String _kRetried = '_retried';
  static const String _kSkipRiskControl = '_skipRiskControl';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_seeded) {
      final existing = await _cookieJar.loadForRequest(BilibiliSource._apiUri);
      if (existing.where((c) => c.name == 'buvid3').isEmpty) {
        await _seedCookie(_generateBuvid(), _generateBuvid());
      }
      _seeded = true;
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      handler.next(response);
      return;
    }

    final requestOptions = response.requestOptions;
    if (requestOptions.extra[_kSkipRiskControl] != true &&
        data['code'] == BilibiliSource._riskControlCode &&
        requestOptions.extra[_kRetried] != true) {
      requestOptions.extra[_kRetried] = true;
      try {
        await _refreshFingerprint();
        final retryResponse = await _dio.fetch(requestOptions);
        handler.resolve(retryResponse);
        return;
      } catch (_) {
        handler.next(response);
        return;
      }
    }

    final code = data['code'];
    if (code != 0) {
      handler.reject(
        DioException(
          requestOptions: requestOptions,
          response: response,
          error: SourceException(
            code: code as int,
            message: data['message'] as String? ?? 'Unknown error',
          ),
          type: DioExceptionType.badResponse,
        ),
      );
      return;
    }

    handler.next(response);
  }

  Future<void> _refreshFingerprint() async {
    final response = await _dio.get<Map<String, dynamic>>(
      BilibiliSource._fingerprintApi,
      options: Options(extra: {_kSkipRiskControl: true}),
    );
    final data = response.data?['data'];
    if (data is! Map) return;
    final buvid3 = data['b_3'] as String?;
    final buvid4 = data['b_4'] as String?;
    if (buvid3 == null || buvid4 == null) return;
    await _cookieJar.delete(BilibiliSource._apiUri);
    await _seedCookie(buvid3, buvid4);
  }

  Future<void> _seedCookie(String buvid3, String buvid4) async {
    final bNut = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    await _cookieJar.saveFromResponse(
      BilibiliSource._apiUri,
      [
        Cookie('buvid3', buvid3),
        Cookie('buvid4', buvid4),
        Cookie('b_nut', '$bNut'),
        Cookie('_uuid', buvid3),
        Cookie('buvid_fp', buvid3),
      ],
    );
  }

  static String _generateBuvid() {
    final r = Random();
    String hex(int n) =>
        List.generate(n, (_) => '0123456789ABCDEF'[r.nextInt(16)]).join();
    return '${hex(8)}-${hex(4)}-${hex(4)}-${hex(4)}-${hex(12)}';
  }
}
