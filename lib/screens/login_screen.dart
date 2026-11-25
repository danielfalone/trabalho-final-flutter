import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/auth_repository.dart';
import '../repositories/favorites_repository.dart';
import '../widgets/custom_text_field.dart';
import 'list_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Preencha o e-mail e a senha.', Colors.red);
      return;
    }

    AuthRepository auth = Provider.of<AuthRepository>(context, listen: false);
    FavoritesRepository favorites = Provider.of<FavoritesRepository>(
      context,
      listen: false,
    );

    String? error = await auth.login(email, password);
    if (!mounted) return;

    if (error != null) {
      _showMessage(error, Colors.red);
      return;
    }

    await favorites.loadFavorites(auth.user!.id!);
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Minha Loja",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    isPassword: true,
                    labelText: "Senha",
                    prefixIcon: Icon(Icons.lock),
                    controller: _passwordController,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text("Entrar"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text("Cadastrar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
