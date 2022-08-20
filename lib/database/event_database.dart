import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/event.dart';

class EventDatabase {
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('event.db');
    return _database!;
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = 'TEXT NOT NULL';
    await db.execute('''
      CREATE TABLE $tableEvents (
          ${EventFields.id} $idType,
          ${EventFields.title} $stringType,
          ${EventFields.description} $stringType,
          ${EventFields.date} $stringType,
          ${EventFields.type} $stringType,
          ${EventFields.amount} $stringType
      )
    ''');
  }

  Future<Event> insert(Event event) async {
    final db = await instance.database;

    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id: id);
  }

  Future<List<Event>?> queryAll() async {
    final db = await instance.database;

    final data = await db.query(tableEvents);
    if (data.isNotEmpty) {
      return data.map((e) => Event.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  Future<int> update(Event event) async {
    final db = await instance.database;

    return await db.update(tableEvents, event.toJson(),
        where: '${EventFields.id} = ?', whereArgs: [event.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db
        .delete(tableEvents, where: '${EventFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
