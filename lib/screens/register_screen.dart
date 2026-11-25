import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/auth_repository.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  Future<void> _register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage('Preencha todos os campos.', Colors.red);
      return;
    }
    if (!email.contains('@')) {
      _showMessage('Informe um e-mail válido.', Colors.red);
      return;
    }
    if (password.length < 6) {
      _showMessage('A senha deve ter pelo menos 6 caracteres.', Colors.red);
      return;
    }

    AuthRepository auth = Provider.of<AuthRepository>(context, listen: false);

    String? error = await auth.register(name, email, password);
    if (!mounted) return;

    if (error != null) {
      _showMessage(error, Colors.red);
      return;
    }

    _showMessage('Cadastro realizado com sucesso!', Colors.green);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 73, 109),
        foregroundColor: Colors.white,
      ),
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
                  CustomTextField(
                    labelText: "Nome",
                    prefixIcon: Icon(Icons.person),
                    controller: _nameController,
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
                      onPressed: _register,
                      child: Text("Cadastrar"),
                    ),
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
