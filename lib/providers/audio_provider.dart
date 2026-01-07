import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

class AudioProvider extends ChangeNotifier {
  final AudioRecorder _recorder = AudioRecorder();
  
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  
  String? _recordedFilePath;
  String? get recordedFilePath => _recordedFilePath;
  
  Duration _recordingDuration = Duration.zero;
  Duration get recordingDuration => _recordingDuration;
  
  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      _isRecording = true;
      _recordingDuration = Duration.zero;
      notifyListeners();
      
      final path = '/storage/emulated/0/Kumkummee/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(const RecordConfig(), path: path);
      _recordedFilePath = path;
      
      // Update duration every second
      _updateDuration();
    }
  }
  
  Future<void> stopRecording() async {
    await _recorder.stop();
    _isRecording = false;
    notifyListeners();
  }
  
  void _updateDuration() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isRecording) {
        _recordingDuration += const Duration(seconds: 1);
        notifyListeners();
        _updateDuration();
      }
    });
  }
  
  void reset() {
    _isRecording = false;
    _recordedFilePath = null;
    _recordingDuration = Duration.zero;
    notifyListeners();
  }
  
  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }
}
