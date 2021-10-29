/*
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.instance();

  DatabaseHelper.instance();

  factory DatabaseHelper() => _instance;

  late Database database;
  final String _tableName = 'tasks';
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  Future<Database> _createDatabase() async {
    String path = join(await getDatabasesPath(), 'database.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: onOpen,
    ));
    return database;
  }

  _onCreate(Database db, int version) async {
    db.transaction(
      (txn) => txn.execute(
        'create table $_tableName (id integer primary key , title text , content text , date text , time text , colorNumber integer , status text   ) ',
      ),
    );
  }

  FutureOr<void> onOpen(Database db) {
    print('Database opened ');
    getAllDateFromDatabase();
    _createDatabase().then(
            (value) {
              database = value;
          emit(AppCreateDatabaseState());
          },);
  }

  insertIntoDatabase({
    required String title,
    required String content,
    required String date,
    required String time,
    required int colorNumber,
  }) async {
    Database db = await _createDatabase();
    return db.insert(
      _tableName,
      {
        'title': title,
        'content': content,
        'date': date,
        'time': time,
        'colorNumber': colorNumber,
      },
    ).then(
      (value) {
        print('Inserted Successfully $value');
      },
    ).catchError((onError) {
      print('Error Happened While Insert ${onError.toString()}');
    });
  }

  getAllDateFromDatabase() async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    Database db = await _createDatabase();
    return db.query(_tableName).then(
      (value) {
        value.forEach(
          (element) {
            if (element['status'] == 'new') {
              newTasks.add(element);
            } else if (element['status'] == 'done') {
              doneTasks.add(element);
            } else {
              archivedTasks.add(element);
            }
          },
        );
        emit(AppGetDatabaseState());
      },
    );
  }

  updateDatabase({required String status, required int id}) async {
    Database db = await _createDatabase();
    return db
        .update(
            _tableName,
            {
              'id': id,
              'status': status,
            },
            where: 'id = ? ',
            whereArgs: [id])
        .then(
      (value) {
        getAllDateFromDatabase();
        emit(AppUpdateDatabaseState());
      },
    );
  }

  deleteDatabase({required int id}) async {
    Database db = await _createDatabase();
    return db.delete(_tableName, where: 'id = ? ', whereArgs: [id]).then(
      (value) {
        getAllDateFromDatabase();
        emit(AppDeleteDatabaseState());
      },
    );
  }
}
*/
