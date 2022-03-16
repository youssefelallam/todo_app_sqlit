import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/module/todoModule.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'toDo.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "todo" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "done" boolean DEFAULT 0
  )
 ''');
    print(" onCreate =====================================");
  }

  readData() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query("todo");
    return response;
  }

  insertData(Todo todo) async {
    Database? mydb = await db;
    int response = await mydb!.insert("todo", todo.toMap());
    return response;
  }

  updateData(Todo todo, int id) async {
    Database? mydb = await db;
    int response = await mydb!
        .update("todo", todo.toMap(), where: 'id = ?', whereArgs: [id]);
    return response;
  }

  deleteData(String mywhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete("todo", where: mywhere);
    return response;
  }

  deleting_db() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'toDo.db');
    await deleteDatabase(path);
  }
}
