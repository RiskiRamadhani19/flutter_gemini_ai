import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai/models/chat_model.dart';

class HomeNotifier extends ChangeNotifier {
  final BuildContext context;

  HomeNotifier({required this.context}){
    getData();
  }

  List<String> chats = [];
  TextEditingController chat = TextEditingController();
  sendMessage() {
    chats.add(chat.text);
    chat.clear();
    notifyListeners();
  }
  
  List<ChatModel> listChat = [];
  getData() async{
    Dio dio = Dio();
    final response = await dio.get("https://tegaldev.metimes.id/chat-sample");
    final results = jsonDecode(response.data);

    for (Map<String, dynamic> i in results['data']){
      listChat.add(ChatModel.fromJson(i));
    }
    notifyListeners();
    print(listChat.length);
  }
}

//   List<ChatModel> listChat = [];
//   getData() async{
//     Dio dio = Dio();
//     final response = await dio.get("https://tegaldev.metimes.id/chat-sample");
//     final results = jsonDecode(response.data);

//     for (Map<String, dynamic> i in results['data']){
//       listChat.add(ChatModel(
//         chat: i ['chat'], 
//         posisi: i['posisi'], 
//         createdDate: i ['createdDate'], 
//         type: i ['type'], 
//         status: i ['status']));
//     }
//     notifyListeners();
//     print(listChat.length);
//   }
// }

// class ChatModel{
//   final String posisi;
//   final String chat;
//   final String createdDate;
//   final String type;
//   final String status;

//   ChatModel(
//     {required this.posisi, 
//     required this.chat, 
//     required this.createdDate, 
//     required this.type, 
//     required this.status});
// }
