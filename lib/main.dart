import 'package:flutter/material.dart';
import 'package:flutter_flashcards/pages/Home.dart';

void main() {
  runApp(MaterialApp(
    routes: {'/': (context) => const Home()},
    debugShowCheckedModeBanner: false,
  ));
}
