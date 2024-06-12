import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:space_pod/model/chat_message_model.dart';
import 'package:space_pod/repos/chart_repos.dart';

part 'chat_bloc_event.dart';
part 'chat_bloc_state.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBlocBloc() : super(ChatSuccessState(messages: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEven);
  }
  List<ChatMessageModel> messeges = [];
  bool generating = false;
  FutureOr<void> chatGenerateNewTextMessageEven(
      ChatGenerateNewTextMessageEvent event,
      Emitter<ChatBlocState> emit) async {
    messeges.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messeges));
    generating = true;
    String generatedtext = await ChatRepo.ChatTextGenerationRepo(messeges);
    if (generatedtext.length > 0) {
      messeges.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedtext)]));
      emit(ChatSuccessState(messages: messeges));
    }
    generating = false;
  }
}
