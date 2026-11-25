import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/favorites_repository.dart';
import '../repositories/product_repository.dart';
import '../widgets/product_tile.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  ProductRepository _repository = ProductRepository();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();

    bool logged = Provider.of<AuthRepository>(context, listen: false).isLogged;
    if (!logged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _goToLogin();
      });
    }

    _productsFuture = _repository.fetchProducts();
  }

  void _goToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
  }

  void _logout() {
    Provider.of<AuthRepository>(context, listen: false).logout();
    Provider.of<FavoritesRepository>(context, listen: false).clear();
    _goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 73, 109),
        //backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: 'Favoritos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar os produtos.'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Product> products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, position) {
              return ProductTile(products[position]);
            },
          );
        },
      ),
    );
  }
}
