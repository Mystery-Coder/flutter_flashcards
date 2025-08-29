import 'package:flutter/material.dart';
import 'package:flutter_flashcards/db_helper.dart';
// import 'package:sqflite/sqlite_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    testSQL() async {
      final DatabaseHelper singleInstance = DatabaseHelper.singleInstance;

      await singleInstance.rawInstert(
          FlashCardData(question: "SQL?", answer: "Structured Query Language"));
      await singleInstance
          .rawInstert(FlashCardData(question: "JS?", answer: "JavaScript"));

      final List<FlashCardData> flashcards =
          await singleInstance.rawQueryAllRows();

      for (var i = 0; i < flashcards.length; i++) {
        print(flashcards[i].question + " " + flashcards[i].answer);
      }
    }

    testSQL();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: const Text("Study Flashcards"), backgroundColor: Colors.blue),
    ));
  }
}
