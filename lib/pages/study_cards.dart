import 'package:flutter/material.dart';
import 'package:flutter_flashcards/db_helper.dart';
import 'package:flip_card/flip_card.dart';

class StudyCards extends StatefulWidget {
  static const routeName = "/study_cards";
  final List<FlashCardData> flashcards;

  const StudyCards({super.key, required this.flashcards});

  @override
  State<StudyCards> createState() => _StudyCardsState();
}

class _StudyCardsState extends State<StudyCards> {
  int questionIdx = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Study"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Tap the card if you don't know the answer else click Next, you are Timed"),
            Text("Question ${questionIdx + 1}"),
            FlipCard(
              fill: Fill
                  .fillBack, // Fill the back side of the card to make in the same size as the front.
              direction: FlipDirection.HORIZONTAL, // default
              side: CardSide.FRONT, // The side to initially display.
              front: Card.filled(
                elevation: 5,
                margin: EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.flashcards[questionIdx].question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              back: Card.filled(
                elevation: 5,
                margin: EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.flashcards[questionIdx].answer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    if (questionIdx < widget.flashcards.length - 1) {
                      questionIdx += 1;
                    }
                  });
                },
                child: const Text("Next"))
          ],
        ),
      ),
    ));
  }
}
