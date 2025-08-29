import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "flashcards.db";
  static const _databaseVersion = 1;

  static const table = 'StoredFlashcards';
  static const columnId = '_id';
  static const columnQuestion = 'question';
  static const columnAnswer = 'answer';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper singleInstance =
      DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnQuestion TEXT NOT NULL,
            $columnAnswer TEXT NOT NULL
          )
          ''');
    });
  }

  //Raw SQL

  Future<int> rawInstert(FlashCardData flashCardData) async {
    Database db = await singleInstance.database;
    return await db.rawInsert('''
    INSERT INTO $table ($columnQuestion, $columnAnswer) VALUES (?, ?)
''', [flashCardData.question, flashCardData.answer]);
  }

  Future<List<FlashCardData>> rawQueryAllRows() async {
    Database db = await singleInstance.database;
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
    SELECT * FROM $table
''');

    return List.generate(
        rows.length, (idx) => FlashCardData.fromMap(rows[idx]));
  }
}

// Model class for our data
class FlashCardData {
  int? id;
  String question;
  String answer;

  FlashCardData({this.id, required this.question, required this.answer});

  Map<String, dynamic> toMap() {
    return {
      // id is handled by the database, so we don't include it when inserting
      // but we need it for updates and deletes.
      'question': question,
      'answer': answer,
    };
  }

  // A factory constructor to create a MyData from a Map
  factory FlashCardData.fromMap(Map<String, dynamic> map) {
    return FlashCardData(
      id: map['_id'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}
