import 'package:chat_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential? userCredential = await signInWithGoogle(
            );
                   final user = userCredential!.user;
              if (user != null) {
           final userDocSnapshot = await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.email)
                        .get();
                       
                    if (userDocSnapshot.exists) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    } 
                    else {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.email)
                          .set({
                        'displayName': user.displayName,
                        'email': user.email,
                        'photoURL': user.photoURL,
                      });
                    }
              }

            print('Signed in as ${userCredential.user?.displayName}');
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }



  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
try{   
   final GoogleSignInAccount? googleUser = await GoogleSignIn(
      clientId: '756164132716-bdm54tvuj9em3h0ufvn8j6nhb1lekbko.apps.googleusercontent.com' 
   ).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;


    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

     UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);

     return userCredential;
}

 catch (e) {
     print(e);

    //  print(e.code);
    }
  }
}


