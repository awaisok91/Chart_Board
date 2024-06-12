import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/bloc/chat_bloc_bloc.dart';
import 'package:space_pod/model/chat_message_model.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatBlocBloc(),
        child: _HomepageBody(),
      ),
    );
  }
}

class _HomepageBody extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatBlocBloc _chatBloc = BlocProvider.of<ChatBlocBloc>(context);

    return BlocConsumer<ChatBlocBloc, ChatBlocState>(
      listener: (context, state) {
        // Handle state changes if needed
      },
      builder: (context, state) {
        if (state is ChatSuccessState) {
          List<ChatMessageModel> messages = state.messages;

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/space.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Space Pod",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle image search button tap
                        },
                        icon: Icon(
                          Icons.image_search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: message.role == "user"
                              ? Colors.amber.withOpacity(0.2)
                              : Colors.purple.shade200.withOpacity(0.2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.role == "user" ? "User" : "Space Pod",
                              style: TextStyle(
                                fontSize: 15,
                                color: message.role == "user"
                                    ? Colors.amber
                                    : Colors.purple.shade200,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              message.parts.first.text,
                              style: TextStyle(
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (_chatBloc.generating)
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Lottie.asset("assets/loader/loader.json"),
                      ),
                      SizedBox(width: 20),
                      Text("Loading..."),
                    ],
                  ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          style: TextStyle(color: Colors.black),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            fillColor: Colors.white,
                            hintText: "Ask Something from AI",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          final text = _textEditingController.text;
                          if (text.isNotEmpty) {
                            _textEditingController.clear();
                            _chatBloc.add(ChatGenerateNewTextMessageEvent(
                                inputMessage: text));
                          }
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(); // Handle other states or loading state
        }
      },
    );
  }
}
