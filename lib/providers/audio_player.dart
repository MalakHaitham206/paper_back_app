// services/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { stopped, playing, paused }

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  FlutterTts? _flutterTts;
  TtsState _state = TtsState.stopped;
  String _currentText = '';

  // Callbacks
  Function(TtsState)? onStateChanged;

  TtsState get state => _state;
  bool get isPlaying => _state == TtsState.playing;
  bool get isPaused => _state == TtsState.paused;

  Future<void> initialize() async {
    _flutterTts = FlutterTts();

    await _flutterTts!.setLanguage('en-US');
    await _flutterTts!.setSpeechRate(0.4);
    await _flutterTts!.setVolume(1.0);
    await _flutterTts!.setPitch(1.0);

    // Set up handlers
    _flutterTts!.setStartHandler(() {
      _updateState(TtsState.playing);
    });

    _flutterTts!.setCompletionHandler(() {
      _updateState(TtsState.stopped);
    });

    _flutterTts!.setCancelHandler(() {
      _updateState(TtsState.stopped);
    });
  }

  Future<void> speak(String text) async {
    if (_flutterTts == null) await initialize();

    _currentText = text;
    await _flutterTts!.speak(text);
  }

  Future<void> pause() async {
    if (_flutterTts != null && _state == TtsState.playing) {
      await _flutterTts!.pause();
      _updateState(TtsState.paused);
    }
  }

  Future<void> resume() async {
    if (_flutterTts != null && _state == TtsState.paused) {
      // TTS doesn't support true resume, so restart from beginning
      await _flutterTts!.speak(_currentText);
    }
  }

  Future<void> stop() async {
    if (_flutterTts != null) {
      await _flutterTts!.stop();
      _updateState(TtsState.stopped);
    }
  }

  Future<void> setSpeechRate(double rate) async {
    if (_flutterTts != null) {
      await _flutterTts!.setSpeechRate(rate);
    }
  }

  void _updateState(TtsState newState) {
    _state = newState;
    onStateChanged?.call(newState);
  }

  void dispose() {
    _flutterTts?.stop();
  }
}
