import 'package:flutter/foundation.dart';
import '../databases/helpers/user_helper.dart';
import '../models/user_model.dart';

class AuthRepository extends ChangeNotifier {
  UserHelper _userHelper = UserHelper();
  User? _user;

  User? get user => _user;

  bool get isLogged => _user != null;

  Future<String?> register(String name, String email, String password) async {
    email = email.trim().toLowerCase();

    User? existing = await _userHelper.getByEmail(email);
    if (existing != null) {
      return 'Este e-mail já está cadastrado.';
    }

    await _userHelper.saveUser(
      User(name: name.trim(), email: email, password: password),
    );
    return null;
  }

  Future<String?> login(String email, String password) async {
    User? user = await _userHelper.login(email.trim().toLowerCase(), password);

    if (user == null) {
      return 'E-mail ou senha inválidos.';
    }

    _user = user;
    notifyListeners();
    return null;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
