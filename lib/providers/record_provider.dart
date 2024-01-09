import 'package:flutter/material.dart';










class RecordProvider extends ChangeNotifier {
  bool _isRecording = false;

  bool get isRecording => _isRecording;

  void startStopRecording() {
    _isRecording = !_isRecording;
    notifyListeners();  // يعلم المستهلكين بالتغيير في _isRecording
    if (_isRecording) {
      // بدء التسجيل
      // يمكنك هنا استخدام المنطق الخاص ببدء التسجيل
    } else {
      // إيقاف التسجيل
      // يمكنك هنا استخدام المنطق الخاص بإيقاف التسجيل
    }
  }
}


// class RecordProvider with ChangeNotifier {
//   bool _isRecording = false;

//   bool get isRecording => _isRecording;

// late FlutterSoundRecorder _flutterSound;


// late String _audioPath;

//   get startStopRecording => null;


// void _startStopRecording() async {
//   if (_isRecording) {
//     await _flutterSound.stopRecorder();
//     _audioPath = await _flutterSound.filePath;
//     // Convert audio to text
//     await convertAudioToText(_audioPath);
//   } else {
//     await _flutterSound.startRecorder(
//       codec: Codec.mp3,  // تحديد الصيغة كـ MP3
//     );
//   }

//   setState(() {
//     _isRecording = !_isRecording;
//   });
// }

// Future<void> convertAudioToText(String filePath) async {
//   // استخدم دالة convertSpeechToText لتحويل الصوت إلى نص
//   String text = await ApiService.convertSpeechToText(filePath);
//   print('Converted text: $text');
// }



// }
