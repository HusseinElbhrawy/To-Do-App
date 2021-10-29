import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_last_version/modules/archived_tasks_screen.dart';
import 'package:to_do_last_version/modules/done_tasks_screen.dart';
import 'package:to_do_last_version/modules/tasks/all_tasks_screen.dart';
import 'package:to_do_last_version/shared/cubit/status.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List allScreens = [
    const AllTasksScreen(),
    const ArchivedTasksScreen(),
    const DoneTasksScreen(),
  ];

  void changeIndexOfScreen(int i) {
    currentIndex = i;
    emit(ChangeScreenIndex());
  }

  int colorIndex = 0;
  List colors = [
    Colors.lightBlue[100],
    Colors.teal[100],
    Colors.pink,
    Colors.amberAccent[100],
    Colors.indigo[100],
    Colors.orange[100],
    Colors.deepPurple[100],
    Colors.lightGreen[100],
  ];

  void changeColor(int i) {
    colorIndex = i;
    emit(ChangeColor());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  String tableName = 'tasks_table_to_do_app';

  /* createDatabase() async {
    String path = join(await getDatabasesPath(), 'to_do_app_database.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );
    return await database;
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db
        .execute(
            'create table $tableName (id integer primary key , title text , task text , date text , time text , colorNumber integer , status text )')
        .then((value) {
      print('Table Created ');
    }).catchError((onError) {
      print('Error Happened While Create Table ${onError.toString()})');
    });
  }

  FutureOr<void> _onOpen(Database db) {
    print('Database is Opened');
    getDataFromDatabase();
    database = db;
    emit(AppCreateDatabaseState());
  }*/

  void createDatabase() {
    openDatabase('todo1.db', version: 1, onCreate: (database, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE all_tasks_table (id INTEGER PRIMARY KEY, title TEXT,task TEXT, date TEXT, time TEXT,colorNumber INTEGER, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error When Table Created ${error.toString()}');
      });
    }, onOpen: (database) {
      print('Database Opened');
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertIntoDatabase({
    required String title,
    required String task,
    required String date,
    required String time,
    required int colorNumber,
  }) async {
    return await database.transaction((txn) => txn
            .rawInsert(
                'insert into all_tasks_table(title,task ,date, time,colorNumber, status) values("$title","$task","$date","$time",$colorNumber,"new")')
            .then((value) {
          print('$value inserted successfully');
          emit(AppInsertDatabaseState());

          getDataFromDatabase(database);
        }).catchError((error) {
          print('Error When Inserted New Record ${error.toString()}');
        }));
  }

  /*insertIntoDatabase({
    required String title,
    required String task,
    required String date,
    required String status,
    required String time,
    required int colorNumber,
  }) async {
    Database db = await createDatabase();
    db.insert(
      tableName,
      {
        'title': title,
        'task': task,
        'date': date,
        'time': time,
        'colorNumber': colorNumber,
        'status': status,
      },
    ).then((value) {
      print('Inserted Successfully $value');
      emit(AppInsertDatabaseState());
      getDataFromDatabase();
    }).catchError((onError) {
      print('Error Happened While Inserting ${onError.toString()}');
    });
  }*/

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('select * from all_tasks_table').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetDatabaseState());
    });
  }
  /*getDataFromDatabase() async {
    newTasks = [];
    doneTasks = [];
    arTasks = [];
    Database db = await createDatabase();
    db.query(tableName).then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            arTasks.add(element);
          }
        },
      );
      emit(AppGetDatabaseState());
    });
  }
*/

  void updateDatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate('UPDATE all_tasks_table SET status = ? WHERE id = ?',
        [status, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  /* updateDatabase({
    required String status,
    required int id,
  }) async {
    Database db = await createDatabase();
    db
        .update(
      tableName,
      {
        'status': status,
      },
      where: 'id = ? ',
      whereArgs: [id],
    )
        .then((value) {
      print('Updated Successfully $value');
      getDataFromDatabase();
      emit(AppUpdateDatabaseState());
    });
  }*/

  updateTask(
      {required int id,
      required int color,
      required String title,
      required String task,
      required String date,
      required String time,
      required String status,
      required List taskList}) {
    database
        .update(
      'all_tasks_table',
      {
        'id': id,
        'title': title,
        'task': task,
        'date': date,
        'time': time,
        'colorNumber': color,
        'status': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    )
        .then((value) {
      for (int i = 0; i < taskList.length; i++) {
        if (title == newTasks[i]['title'] ||
            task == newTasks[i]['task'] ||
            date == newTasks[i]['date'] ||
            time == newTasks[i]['time'] ||
            color == newTasks[i]['colorNumber']) {
          taskList.removeAt(i);
        }
      }
      taskList.add({
        'id': id,
        'title': title,
        'task': task,
        'date': date,
        'time': time,
        'colorNumber': color,
        'status': status,
      });
      getDataFromDatabase(database);
      emit(AppUpdateTask());
    });
  }
  /*updateTask(
      {required int id,
      required int color,
      required String title,
      required String task,
      required String date,
      required String time,
      required String status,
      required List taskList}) async {
    Database db = await createDatabase();
    db
        .update(
      'all_tasks_table',
      {
        'id': id,
        'title': title,
        'task': task,
        'date': date,
        'time': time,
        'colorNumber': color,
        'status': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    )
        .then((value) {
      for (int i = 0; i < taskList.length; i++) {
        if (title == newTasks[i]['title'] ||
            task == newTasks[i]['task'] ||
            date == newTasks[i]['date'] ||
            time == newTasks[i]['time'] ||
            color == newTasks[i]['colorNumber']) {
          taskList.removeAt(i);
        }
      }
      taskList.add({
        'id': id,
        'title': title,
        'task': task,
        'date': date,
        'time': time,
        'colorNumber': color,
        'status': status,
      });
      // getDataFromDatabase(database);
      getDataFromDatabase();
      emit(AppUpdateTask());
    });
  }
*/

  void deleteDatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM all_tasks_table WHERE id = ?', [id]).then(
        (value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  bool isDark = false;
  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
}
