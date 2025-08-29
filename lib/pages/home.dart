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

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
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
  late TabController _tabController;
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // 4. Dispose the controller when the widget is disposed
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Study Flashcards"),
          backgroundColor: Colors.blue,
          // 5. Add the TabBar to the bottom of the AppBar
        ),
        // 6. Use TabBarView as the body
        body: TabBarView(
          controller: _tabController,
          children: const [
            // Content for the "Home" tab
            Center(child: Text("This is the Home Page")),

            // Content for the "Decks" tab
            Center(child: Text("This is the Decks Page")),
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.add), text: "New"),
            Tab(icon: Icon(Icons.folder), text: "Saved"),
          ],
          labelColor: Colors.blue,
        ),
      ),
    );
  }
}
