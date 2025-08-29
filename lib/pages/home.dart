import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flashcards/db_helper.dart';
import 'package:http/http.dart' as http;
// import 'package:sqflite/sqlite_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // @override
  // void initState() {
  //   super.initState();

  //   testSQL() async {
  //     final DatabaseHelper singleInstance = DatabaseHelper.singleInstance;

  //     await singleInstance.rawInstert(
  //         FlashCardData(question: "SQL?", answer: "Structured Query Language"));
  //     await singleInstance
  //         .rawInstert(FlashCardData(question: "JS?", answer: "JavaScript"));

  //     final List<FlashCardData> flashcards =
  //         await singleInstance.rawQueryAllRows();
  //     var res = await http.get(Uri.parse("http://10.0.2.2:8080/"));
  //     var data = jsonDecode(res.body);
  //     print(data);
  //     for (var i = 0; i < flashcards.length; i++) {
  //       print(flashcards[i].id.toString() +
  //           " " +
  //           flashcards[i].question +
  //           " " +
  //           flashcards[i].answer);
  //     }
  //   }

  //   testSQL();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("Study Flashcards"), backgroundColor: Colors.blue),
    ));
  }
}
