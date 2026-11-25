import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'helpers/favorite_helper.dart';
import 'helpers/user_helper.dart';

class DatabaseHelper {
  Database? _db;

  // Singleton: apenas uma instância do banco em toda a aplicação.
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'favoritosDatabase.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgradeDB,
    );
  }

  Future _onCreateDB(Database db, int newVersion) async {
    await db.execute(UserHelper.createScript);
    await db.execute(FavoriteHelper.createScript);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS ${FavoriteHelper.tableName};");
      await db.execute("DROP TABLE IF EXISTS ${UserHelper.tableName};");
      await _onCreateDB(db, newVersion);
    }
  }
}
