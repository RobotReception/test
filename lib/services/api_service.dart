import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Alrazi_boot/constants/api_consts.dart';
import 'package:Alrazi_boot/models/chat_model.dart';
import 'package:Alrazi_boot/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'connect_with_pinceone.dart';


Future<void> sendDataToPython(String data) async {
  final Uri apiUrl = Uri.parse('https://langro-chat-qwgvyvdz7-mo-alsheblis-projects.vercel.app/');
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final Map<String, dynamic> requestData = {'data': data,};

  // إرسال البيانات بشكل غير متزامن
  final Future<http.Response> responseFuture =
      http.post(apiUrl, headers: headers, body: jsonEncode(requestData));

  // استمرار تشغيل التطبيق بدون انتظار الرد
  responseFuture.then((http.Response response) {
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('الرد من الخادم: ${responseData['result']}');
    } else {
      print('فشلت العملية: ${response.reasonPhrase}');
    }
  });
}


  class ApiService {

    Future<String> convertSpeechToText(String filePath) async {
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(({"Authorization": "Bearer $API_KEY"}));
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "en";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var response = await request.send();
    var newresponse = await http.Response.fromStream(response);
    final responseData = json.decode(newresponse.body);

    return responseData['text'];
  }

    

      // Send Message fct
static Future<List<ChatModel>> sendMessage(
  {required String message}) async {
  
  try {
     final findMatching = FindMatching();
  final respons = await findMatching.respons(message);

      List<ChatModel> chatList = [ChatModel(msg: respons, chatIndex: 1)];
      return chatList;
   
    
  } catch (e) {
    log('حدث خطأ: $e');
    throw Exception('حدث خطأ: $e');
  }
}

  }

