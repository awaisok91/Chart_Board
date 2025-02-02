import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:space_pod/model/chat_message_model.dart';
import 'package:space_pod/utils/constants.dart';

class ChatRepo {
  static Future<String> ChatTextGenerationRepo(
      List<ChatMessageModel> PreviousMessage) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=${apikey}",
          data: {
            "contents": PreviousMessage.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 1,
              "topK": 0,
              "topP": 0.95,
              "maxOutputTokens": 8192,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }
      return '';
    } catch (e, stackTrace) {
      log(e.toString());
      return '';
    }
  }
}
