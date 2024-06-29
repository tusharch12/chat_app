import 'package:chat_app/bloc/web_socket_bloc/web_socket.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
     WidgetsFlutterBinding.ensureInitialized();
   Firebase.initializeApp(
options: const FirebaseOptions(apiKey:"AIzaSyCEQWl3WeMeFxZ41B90t7f2B8BltKMgA-4",
appId:"1:756164132716:web:0f806312efee4be3b9bd49",
authDomain:
          'chatapp-d763e.firebaseapp.com',
messagingSenderId:"756164132716",
projectId:"chatapp-d763e",
storageBucket:"chatapp-d763e.appspot.com"
));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> WebSocketBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const CheckLoginStatus(),
        )
      
    );
  }
}


class CheckLoginStatus extends StatefulWidget {
  const CheckLoginStatus({super.key});

  @override
  State<CheckLoginStatus> createState() => _checkLoginStatusState();
}

class _checkLoginStatusState extends State<CheckLoginStatus> {

Future <DocumentSnapshot>check()async{
  final User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore instance = FirebaseFirestore.instance;
  DocumentSnapshot userSnapshot =
        await instance.collection('users').doc(user?.uid ?? 'no_id').get();
  return userSnapshot;
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: check(), builder: (context,snapshot){

 if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    color: Colors.black,
                    child: const Center(
                        child: CircularProgressIndicator()));
              }
              
    if(snapshot.hasData){
      if(snapshot.data!.exists){
       return  const HomeScreen(); 
      }
      return SignInScreen();
    } else{
      return SignInScreen();
    }         

    });
  }
}

