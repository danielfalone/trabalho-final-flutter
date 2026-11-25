import 'package:flutter/foundation.dart';
import '../databases/helpers/favorite_helper.dart';
import '../models/product_model.dart';

class FavoritesRepository extends ChangeNotifier {
  FavoriteHelper _helper = FavoriteHelper();
  int? _userId;
  List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  double get totalPrice {
    double total = 0.0;
    _favorites.forEach((product) {
      total += product.price;
    });
    return total;
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  Future<void> loadFavorites(int userId) async {
    _userId = userId;
    _favorites = await _helper.getAll(userId);
    notifyListeners();
  }

  Future<void> add(Product product) async {
    _favorites.add(product);
    notifyListeners();
    await _helper.addFavorite(_userId!, product);
  }

  Future<void> remove(Product product) async {
    _favorites.removeWhere((p) => p.id == product.id);
    notifyListeners();
    await _helper.removeFavorite(_userId!, product.id);
  }

  void clear() {
    _userId = null;
    _favorites = [];
    notifyListeners();
  }
}
