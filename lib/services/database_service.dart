import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tnp/app/constants.dart';
import 'package:tnp/exceptions/database_service_exception.dart';

@android
@preResolve
@singleton
class DatabaseService {
  static DatabaseService _instance;
  static Database _database;

  static final String _databaseName = 'IGIT_TnP.db';
  static final int _databaseVersion = 3;

  static const String NotificationTable = "notification";
  static const String NewsTable = 'news';

  @factoryMethod
  static Future<DatabaseService> getInstance() async {
    if (_instance == null) _instance = DatabaseService();
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _instance;
  }

  static Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    ).then((Database db) => db).catchError((error) {
      print('Failed to open database.');
      print(error);
      throw DatabaseServiceException('Failed to open database.');
    });
  }

  static Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $NotificationTable (
          id INTEGER PRIMARY KEY,
          date_and_time TEXT NOT NULL,
          subject TEXT NOT NULL,
          content TEXT NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE $NewsTable (
          id INTEGER PRIMARY KEY,
          date TEXT NOT NULL,
          title TEXT NOT NULL,
          body TEXT NOT NULL,
          link TEXT
        )
      ''');
    } catch (error) {
      print('Failed to create table.');
      print(error);
      throw DatabaseServiceException('Failed to create table.');
    }
  }

  static Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      print("Upgrading database");
      try {
        await db.delete('notification');
        await db.delete('news');
      } catch (e) {
        print("Failed to delete old data in database");
      }
    }
  }

  Future<int> insert(String tableName, List<dynamic> rows) async {
    return await _database.transaction((txn) async {
      int count = 0;
      rows.forEach((row) async {
        int i = await _database.insert(tableName, row);
        count += i;
      });
      return count;
    }).catchError((error) {
      print('Failed to insert into table.');
      print(error);
      throw DatabaseServiceException('Failed to insert into table.');
    });
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    return await _database.query(tableName).catchError((error) {
      print('Failed to fetch from table.');
      print(error);
      throw DatabaseServiceException('Failed to fetch from table.');
    });
  }

  Future<int> deleteTable(String tableName) async {
    return _database.delete(tableName).catchError((error) {
      print('Failed to delete table.');
      print(error);
      throw DatabaseServiceException('Failed to delete table.');
    });
  }
}
