import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/api_service.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  Future<void> saveValueToFile(String value) async {
  final directory = await getApplicationDocumentsDirectory(); // الحصول على مسار مجلد التطبيق
  final file = File('${directory.path}/my_file.txt'); // تحديد مسار الملف
  await file.writeAsString(value); // حفظ القيمة في الملف
}

  void addUserMessage({required String msg}) {
    saveValueToFile(msg);
    print(msg) {
  // TODO: implement print
  throw UnimplementedError();
}
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg}) async {
    chatList.addAll(await ApiService.sendMessage(
      message: msg,

    ));
    notifyListeners();
      print(chatList) {
  // TODO: implement print
  throw UnimplementedError();
}
  }

}
