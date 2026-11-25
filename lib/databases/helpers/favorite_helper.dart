import 'package:sqflite/sqflite.dart';
import '../../models/product_model.dart';
import '../database_helper.dart';

class FavoriteHelper {
  static const String tableName = 'favorites';
  static const String idColumn = 'id';
  static const String userIdColumn = 'userId';
  static const String productIdColumn = 'productId';
  static const String titleColumn = 'title';
  static const String priceColumn = 'price';
  static const String thumbnailColumn = 'thumbnail';

  static String get createScript {
    return "CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$userIdColumn INTEGER NOT NULL, $productIdColumn INTEGER NOT NULL, "
        "$titleColumn TEXT NOT NULL, $priceColumn REAL NOT NULL, "
        "$thumbnailColumn TEXT, UNIQUE($userIdColumn, $productIdColumn));";
  }

  Future<List<Product>> getAll(int userId) async {
    Database db = await DatabaseHelper().db;

    List<Map> returnedFavorites = await db.query(
      tableName,
      where: "$userIdColumn = ?",
      whereArgs: [userId],
    );

    List<Product> favorites = List<Product>.empty(growable: true);

    for (Map favorite in returnedFavorites) {
      favorites.add(Product.fromMap(favorite));
    }
    return favorites;
  }

  Future<int> addFavorite(int userId, Product product) async {
    Database db = await DatabaseHelper().db;

    Map<String, dynamic> map = product.toMap();
    map[userIdColumn] = userId;

    return await db.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> removeFavorite(int userId, int productId) async {
    Database db = await DatabaseHelper().db;

    return await db.delete(
      tableName,
      where: "$userIdColumn = ? AND $productIdColumn = ?",
      whereArgs: [userId, productId],
    );
  }
}
