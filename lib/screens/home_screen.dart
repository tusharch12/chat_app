import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [Dashboard()],
      ),
    );
  }
}

Widget Dashboard(){
return ListView.builder(itemBuilder: (context,index){
  return Text("HEllo");
});
}