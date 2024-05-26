import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatGeminiNotifier extends ChangeNotifier {
  final BuildContext context;

  ChatGeminiNotifier({required this.context});
  final Gemini gemini = Gemini.instance;

List<ChatMessage> listMessage = [];
  ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "Riski Ramadhan",
  );

  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "gemini",
  );

  sendMessage(ChatMessage value) {
    listMessage = [value, ...listMessage];
    try {
      String values = value.text;
      gemini.streamGenerateContent(values).listen((event) {
      String response = event.content!.parts
        ?.fold("", (before, after) => "$before ${after.text}") ?? 
        '';
      ChatMessage resultsMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text: response,);
        
      listMessage = [resultsMessage, ...listMessage];
      notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}