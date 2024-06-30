import 'package:chat_app/bloc/web_socket_bloc/web_socket.dart';
import 'package:chat_app/services/websocketClass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
late TextEditingController _textController;
late WebSocket socket;
  @override
  void initState() {
    socket = WebSocket();
    _textController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: Container(
          height: 100,
          width: 200,
          child:
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter your message',
                ),
               
              ),
          
             
        ),
      ),
      floatingActionButton: FloatingActionButton(
         
                onPressed: () {
                  socket.sendMsg(_textController.text);
                  _textController.clear();

try{                   DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref();

    print(databaseReference.parent);

  databaseReference.push().set({
    'name': 'John Doe',
    'email': 'johndoe@example.com',
    'age': 30,
  });}
  catch(e){
    print(e);
  }

                },
                child: const Icon(Icons.send),
              
      ),
      );
    
  }
}