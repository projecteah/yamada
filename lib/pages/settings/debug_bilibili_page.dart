import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yamada/components/code_card.dart';
import 'package:yamada/locales/app_localizations.dart';
import 'package:yamada/models/audio_stream_model.dart';
import 'package:yamada/providers/sources_provider.dart';

enum _Op { search, detail, streamDash, streamDurl }

class DebugBilibiliPage extends ConsumerStatefulWidget {
  const DebugBilibiliPage({super.key});

  @override
  ConsumerState<DebugBilibiliPage> createState() => _DebugBilibiliPageState();
}

class _DebugBilibiliPageState extends ConsumerState<DebugBilibiliPage> {
  final _inputController = TextEditingController();
  final _cidController = TextEditingController();
  _Op _op = _Op.detail;

  bool _loading = false;
  String? _resultJson;
  String? _error;

  @override
  void dispose() {
    _inputController.dispose();
    _cidController.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) return;
    final cid = int.tryParse(_cidController.text.trim());

    setState(() {
      _loading = true;
      _error = null;
      _resultJson = null;
    });

    try {
      final source = ref.read(bilibiliSourceProvider);
      final Object? payload;
      switch (_op) {
        case _Op.search:
          final r = await source.search(input);
          payload = r.toJson();
          break;
        case _Op.detail:
          final d = await source.getTrackDetail(input, cid: cid);
          payload = d.toJson();
          break;
        case _Op.streamDash:
          final s = await source.getAudioStream(
            input,
            cid: cid,
            format: AudioStreamFormat.dash,
          );
          payload = s.rawJson;
          break;
        case _Op.streamDurl:
          final s = await source.getAudioStream(
            input,
            cid: cid,
            format: AudioStreamFormat.durl,
          );
          payload = s.rawJson;
          break;
      }
      setState(() {
        _resultJson = const JsonEncoder.withIndent('  ').convert(payload);
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.debugBilibili)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'bvid',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _cidController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'cid',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: Text(l10n.search),
                selected: _op == _Op.search,
                onSelected: (_) => setState(() => _op = _Op.search),
              ),
              ChoiceChip(
                label: Text(l10n.detail),
                selected: _op == _Op.detail,
                onSelected: (_) => setState(() => _op = _Op.detail),
              ),
              ChoiceChip(
                label: Text(l10n.debugStreamDash),
                selected: _op == _Op.streamDash,
                onSelected: (_) => setState(() => _op = _Op.streamDash),
              ),
              ChoiceChip(
                label: Text(l10n.debugStreamDurl),
                selected: _op == _Op.streamDurl,
                onSelected: (_) => setState(() => _op = _Op.streamDurl),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _loading ? null : _run,
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(l10n.debugRun),
          ),
          const SizedBox(height: 16),
          CodeCard(
            loading: _loading,
            text: _resultJson,
            error: _error,
            onClear: () => setState(() {
              _resultJson = null;
              _error = null;
            }),
          ),
        ],
      ),
    );
  }
}
