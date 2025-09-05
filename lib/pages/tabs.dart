import 'package:flutter/material.dart';
import 'package:flutter_flashcards/pages/new.dart';

// import 'package:sqflite/sqlite_api.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Study Flashcards",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            New(),
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
