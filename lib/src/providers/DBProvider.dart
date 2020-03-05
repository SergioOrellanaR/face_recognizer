import 'dart:io';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider connection = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database;
  }

  //Connection, inicializa bases de datos de SQFLite
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, "PersonsDB.db");
    String createTableString = 'CREATE TABLE Persons ('
        ' id INTEGER PRIMARY KEY, '
        ' imagePath TEXT, '
        ' name TEXT, '
        ' profession TEXT, '
        ' hobby TEXT'
        ')';

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(createTableString);
    });
  }

//////////////////////////////////////INSERT//////////////////////////////////
  //Crear registros
  Future<int> insertPerson(Person person) async {
    final datab = await database;
    final results = await datab.insert('Persons', person.toJson());
    return results;
  }

//////////////////////////////////////SELECT//////////////////////////////////
  //Obtener todos
  Future<List<Person>> getAllPersons() async {
    List<Person> list = [];

    final datab = await database;
    final response = await datab.query("Persons");

    if (response.isNotEmpty) {
      list = response.map((value) => Person.fromJson(value)).toList();
    }

    return list;
  }

//////////////////////////////////////DELETE//////////////////////////////////

  //Eliminar registros especificos
  Future<int> deletePerson(int id) async {
    final datab = await database;
    int response =
        await datab.delete("Persons", where: "id = ?", whereArgs: [id]);
    return response;
  }
//////////////////////////////////////////////////////////////////////////////

}
