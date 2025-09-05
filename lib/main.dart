import 'package:flutter/material.dart';
import 'package:flutter_flashcards/db_helper.dart';
import 'package:flutter_flashcards/pages/study_cards.dart';
import 'package:flutter_flashcards/pages/tabs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    initialRoute: '/',
    onGenerateRoute: (settings) {
      switch (settings.name) {
        case '/':
          {
            return MaterialPageRoute(builder: (context) => const Tabs());
          }
        case StudyCards.routeName:
          {
            final args = settings.arguments;
            if (args is List<FlashCardData>) {
              return MaterialPageRoute(
                  builder: (context) => StudyCards(
                        flashcards: args,
                      ));
            }
            return _errorRoute();
          }
        default:
          {
            return _errorRoute();
          }
      }
    },
    debugShowCheckedModeBanner: false,
  ));
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Something went wrong with the navigation!'),
      ),
    );
  });
}
