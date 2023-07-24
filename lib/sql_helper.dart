import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //
  static Future<void> createTable(sql.Database database) async {
    await database.execute("CREATE TABLE stud ( id INTEGER PRIMARY KEY"
        " AUTOINCREMENT NOT NULL, name TEXT, email TEXT, "
        "createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('sms.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> addStudent(String name, String email) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'email': email};
    final id = await db.insert('stud', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getStudDetails(int id) async {
    final db = await SQLHelper.db();
    return await db.query('stud', where: " id = ?", whereArgs: [id]);
  }

  static Future<int> updateStudent(int id, String name, String? email) async {
    final db = await SQLHelper.db();
    var data;

    if (email == null) {
      data = {'name': name, 'createdAT': DateTime.now().toString()};
    } else {
      data = {
        'name': name,
        'email': email,
        'createdAT': DateTime.now().toString()
      };
    }

    return db.update('stud', data, where: " id = ?", whereArgs: [id]);
  }

  static Future<int> deleteStudent(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('stud', where: " id = ?", whereArgs: [id]);
  }
}
