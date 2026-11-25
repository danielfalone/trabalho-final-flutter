import 'package:sqflite/sqflite.dart';
import '../../models/user_model.dart';
import '../database_helper.dart';

class UserHelper {
  static const String tableName = 'users';
  static const String idColumn = 'id';
  static const String nameColumn = 'name';
  static const String emailColumn = 'email';
  static const String passwordColumn = 'password';

  static String get createScript {
    return "CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$nameColumn TEXT NOT NULL, $emailColumn TEXT NOT NULL UNIQUE, "
        "$passwordColumn TEXT NOT NULL);";
  }

  // Cadastro: insere um novo usuário na tabela
  Future<User> saveUser(User user) async {
    Database db = await DatabaseHelper().db;
    user.id = await db.insert(tableName, user.toMap());
    return user;
  }

  // Busca um usuário pelo e-mail (usado para não repetir e-mails)
  Future<User?> getByEmail(String email) async {
    Database db = await DatabaseHelper().db;

    List<Map> returnedUser = await db.query(
      tableName,
      columns: [idColumn, nameColumn, emailColumn, passwordColumn],
      where: "$emailColumn = ?",
      whereArgs: [email],
    );

    if (returnedUser.isEmpty) return null;
    return User.fromMap(returnedUser.first);
  }

  // Login: procura um usuário com o e-mail e a senha informados
  Future<User?> login(String email, String password) async {
    Database db = await DatabaseHelper().db;

    List<Map> returnedUser = await db.query(
      tableName,
      columns: [idColumn, nameColumn, emailColumn, passwordColumn],
      where: "$emailColumn = ? AND $passwordColumn = ?",
      whereArgs: [email, password],
    );

    if (returnedUser.isEmpty) return null;
    return User.fromMap(returnedUser.first);
  }
}
