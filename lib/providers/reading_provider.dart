// providers/reading_provider.dart - Enhanced with better text-to-speech control
import 'package:day2_course/model/book_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { stopped, playing, paused }

class ReadingProvider with ChangeNotifier {
  FlutterTts? _flutterTts;
  TtsState _state = TtsState.stopped;
  Book? _currentBook;
  String _currentText = '';
  List<String> _textChunks = [];
  int _currentChunkIndex = 0;
  double _speechRate = 0.6;
  bool _isInitialized = false;
  double _progress = 0.0;

  // Getters
  Book? get currentBook => _currentBook;
  double get speechRate => _speechRate;
  bool get isPlaying => _state == TtsState.playing;
  bool get isPaused => _state == TtsState.paused;
  TtsState get ttsState => _state;
  double get progress => _progress;
  int get currentChunkIndex => _currentChunkIndex;
  int get totalChunks => _textChunks.length;

  Future<void> initialize() async {
    if (!_isInitialized) {
      _flutterTts = FlutterTts();

      // Configure TTS
      await _flutterTts!.setLanguage('en-US');
      await _flutterTts!.setSpeechRate(_speechRate);
      await _flutterTts!.setVolume(1.0);
      await _flutterTts!.setPitch(1.0);

      // Set up handlers
      _flutterTts!.setStartHandler(() {
        _updateState(TtsState.playing);
      });

      _flutterTts!.setCompletionHandler(() {
        _onChunkCompleted();
      });

      _flutterTts!.setCancelHandler(() {
        _updateState(TtsState.stopped);
      });

      _flutterTts!.setErrorHandler((msg) {
        print('TTS Error: $msg');
        _updateState(TtsState.stopped);
      });

      _isInitialized = true;
    }
  }

  Future<void> startReading(Book book) async {
    await initialize();
    _currentBook = book;
    _currentText = book.description;

    // Split text into smaller chunks for better control
    _textChunks = _splitTextIntoChunks(_currentText);
    _currentChunkIndex = 0;
    _progress = 0.0;

    if (_textChunks.isNotEmpty) {
      await _speakCurrentChunk();
    }

    notifyListeners();
  }

  Future<void> startReadingChapter(String chapterContent) async {
    await initialize();
    _currentText = chapterContent;

    // Split text into smaller chunks for better control
    _textChunks = _splitTextIntoChunks(_currentText);
    _currentChunkIndex = 0;
    _progress = 0.0;

    if (_textChunks.isNotEmpty) {
      await _speakCurrentChunk();
    }

    notifyListeners();
  }

  List<String> _splitTextIntoChunks(String text) {
    // Split text into sentences and then group into chunks of reasonable size
    List<String> sentences = text.split(RegExp(r'[.!?]+'));
    List<String> chunks = [];
    String currentChunk = '';

    for (String sentence in sentences) {
      sentence = sentence.trim();
      if (sentence.isEmpty) continue;

      // Add sentence to current chunk if it won't make it too long
      if (currentChunk.length + sentence.length < 200) {
        currentChunk += sentence + '. ';
      } else {
        // Start a new chunk
        if (currentChunk.isNotEmpty) {
          chunks.add(currentChunk.trim());
        }
        currentChunk = sentence + '. ';
      }
    }

    // Add the last chunk if it's not empty
    if (currentChunk.isNotEmpty) {
      chunks.add(currentChunk.trim());
    }

    return chunks.isNotEmpty ? chunks : [text];
  }

  Future<void> _speakCurrentChunk() async {
    if (_currentChunkIndex < _textChunks.length && _flutterTts != null) {
      String chunk = _textChunks[_currentChunkIndex];
      print(
        'Speaking chunk ${_currentChunkIndex + 1}/${_textChunks.length}: ${chunk.substring(0, chunk.length > 50 ? 50 : chunk.length)}...',
      );
      await _flutterTts!.speak(chunk);
    }
  }

  void _onChunkCompleted() {
    _currentChunkIndex++;
    _progress = _textChunks.isNotEmpty
        ? _currentChunkIndex / _textChunks.length
        : 0.0;

    print(
      'Completed chunk ${_currentChunkIndex}/${_textChunks.length}. Progress: ${(_progress * 100).toStringAsFixed(1)}%',
    );

    if (_currentChunkIndex < _textChunks.length) {
      // Continue to next chunk
      _speakCurrentChunk();
    } else {
      // All chunks completed
      _updateState(TtsState.stopped);
      _progress = 1.0;
    }

    notifyListeners();
  }

  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await pause();
    } else if (isPaused) {
      await resume();
    } else if (_textChunks.isNotEmpty) {
      await _speakCurrentChunk();
    }
  }

  Future<void> pause() async {
    if (_flutterTts != null && _state == TtsState.playing) {
      await _flutterTts!.pause();
      _updateState(TtsState.paused);
    }
  }

  Future<void> resume() async {
    if (_flutterTts != null && _state == TtsState.paused) {
      // Flutter TTS doesn't support true resume, so restart current chunk
      await _speakCurrentChunk();
    }
  }

  Future<void> stopReading() async {
    if (_flutterTts != null) {
      await _flutterTts!.stop();
      _updateState(TtsState.stopped);
    }
  }

  Future<void> setSpeechRate(double rate) async {
    _speechRate = rate;
    if (_flutterTts != null) {
      await _flutterTts!.setSpeechRate(rate);
    }
    notifyListeners();
  }

  Future<void> skipToNextChunk() async {
    if (_currentChunkIndex < _textChunks.length - 1) {
      await _flutterTts?.stop();
      _currentChunkIndex++;
      _progress = _currentChunkIndex / _textChunks.length;
      await _speakCurrentChunk();
      notifyListeners();
    }
  }

  Future<void> skipToPreviousChunk() async {
    if (_currentChunkIndex > 0) {
      await _flutterTts?.stop();
      _currentChunkIndex--;
      _progress = _currentChunkIndex / _textChunks.length;
      await _speakCurrentChunk();
      notifyListeners();
    }
  }

  String getCurrentChunkText() {
    if (_currentChunkIndex < _textChunks.length) {
      return _textChunks[_currentChunkIndex];
    }
    return '';
  }

  void _updateState(TtsState newState) {
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts?.stop();
    super.dispose();
  }
}
