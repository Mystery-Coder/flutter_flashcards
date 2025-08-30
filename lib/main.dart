import 'package:flutter/material.dart';
import 'package:flutter_flashcards/pages/tabs.dart';

void main() {
  runApp(MaterialApp(
    routes: {'/': (context) => const Tabs()},
    debugShowCheckedModeBanner: false,
  ));
}
