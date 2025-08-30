import 'package:flutter/material.dart';
import 'package:flutter_flashcards/db_helper.dart';

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  @override
  void initState() {
    super.initState();

    getDB() async {
      final DatabaseHelper singleInstance = DatabaseHelper.singleInstance;

      List<FlashCardData> rows = await singleInstance.rawQueryAllRows();
      // print(rows.length);
    }

    getDB();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text("New Topic"), Text("Add new")],
    );
  }
}
