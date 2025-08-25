import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// A simple radio player service that wraps [AudioPlayer].
///
/// Exposes a small reactive API suitable for UI binding.
class RadioPlayerService extends ChangeNotifier {
  RadioPlayerService({required this.streamUrl});

  final String streamUrl;

  final AudioPlayer _audioPlayer = AudioPlayer();
  ProcessingState _processingState = ProcessingState.idle;
  StreamSubscription<PlayerState>? _playerStateSub;

  bool _initialized = false;
  String? _errorMessage;

  bool get isInitialized => _initialized;
  bool get isPlaying => _audioPlayer.playing;
  bool get isBuffering => _processingState == ProcessingState.loading || _processingState == ProcessingState.buffering;
  String? get errorMessage => _errorMessage;

  Future<void> initialize() async {
    if (_initialized) return;
    try {
      final AudioSession session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      await _audioPlayer.setUrl(streamUrl);
      _playerStateSub = _audioPlayer.playerStateStream.listen((PlayerState state) {
        _processingState = state.processingState;
        notifyListeners();
      });
      _initialized = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> play() async {
    await initialize();
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  @override
  void dispose() {
    _playerStateSub?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}

