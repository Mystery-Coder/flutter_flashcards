import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flashcards/db_helper.dart';
import 'package:flutter_flashcards/pages/study_cards.dart';
import 'package:http/http.dart' as http;

class New extends StatefulWidget {
  const New({super.key});

  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {
  int noOfTopics = 0;
  TextEditingController topicController = TextEditingController();

  @override
  void initState() {
    super.initState();

    getDB() async {
      final DatabaseHelper singleInstance = DatabaseHelper.singleInstance;

      // List<FlashCardData> rows = await singleInstance.rawQueryAllRows();
      final topics = await singleInstance.rawQueryTopics();
      setState(() {
        noOfTopics = topics.length;
      });
    }

    getDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "Currently Saved $noOfTopics topics",
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 75,
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              controller: topicController,
              decoration: const InputDecoration(
                labelText: "Enter New Topic to Study",
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide:
                      BorderSide(color: Colors.blue), // when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide:
                      BorderSide(color: Colors.blue, width: 2), // when focused
                ),
              ),
            )),
        FilledButton.icon(
          onPressed: () async {
            Uri groqURL =
                Uri.parse("https://api.groq.com/openai/v1/chat/completions");
            final jsonSchema = {
              "type": "object",
              "properties": {
                "flashcards": {
                  "type": "array",
                  "description": "A list of flashcard objects.",
                  "items": {
                    "type": "object",
                    "properties": {
                      "question": {
                        "type": "string",
                        "description": "The question for the flashcard."
                      },
                      "answer": {
                        "type": "string",
                        "description": "The detailed answer for the flashcard."
                      }
                    },
                    "required": ["question", "answer"]
                  }
                }
              },
              "required": ["flashcards"]
            };
            final body = {
              "model": "meta-llama/llama-4-maverick-17b-128e-instruct",
              "messages": [
                {
                  "role": "system",
                  "content":
                      "You are a flashcard creation assistant. Your response MUST ONLY be a JSON array of objects. Do not include any other text, preambles, or explanations. The format is [{ \"question\": \"...\", \"answer\": \"...\" }]."
                },
                {
                  "role": "user",
                  "content":
                      "Prepare 5 flashcard type questions for the topic: ${topicController.text}. The questions should be important and meaningful. The answer should have a clear, concise reason in a neat, organized, minimalist manner."
                }
              ],
              "temperature": 0.7,
              "response_format": {
                "type": "json_schema",
                "json_schema": {
                  "name": "flashcard_generator", // The required 'name' property
                  "description":
                      "A schema for generating a list of flashcards.",
                  "schema": jsonSchema // Your schema is nested inside here
                }
              }
            };

            http.Response res = await http.post(groqURL,
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization': "Bearer ${dotenv.env["GROQ_KEY"]}"
                },
                body: jsonEncode(body));

            var cards =
                jsonDecode(res.body)['choices'][0]['message']['content'];
            cards = jsonDecode(cards);
            cards = cards['flashcards'];

            List<FlashCardData> aiCards = [];

            for (var card in cards) {
              aiCards.add(FlashCardData(
                  topic: topicController.text,
                  question: card['question'],
                  answer: card['answer']));
            }
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                StudyCards.routeName, // Use the static routeName
                arguments: aiCards, // Pass your data here
              );
            }
          },
          style: FilledButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // sharp edges
              ),
              backgroundColor: Colors.blue),
          icon: const Icon(Icons.arrow_forward),
          label: const Text("Study"),
        )
      ],
    );
  }
}
