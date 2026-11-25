import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/auth_repository.dart';
import '../repositories/favorites_repository.dart';
import '../widgets/product_tile.dart';
import 'login_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    bool logged = Provider.of<AuthRepository>(context, listen: false).isLogged;
    if (!logged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesRepository _repo = context.watch<FavoritesRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 10, 73, 109),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: _repo.favorites.isEmpty
                ? Center(child: Text("Você ainda não tem favoritos."))
                : ListView.builder(
                    itemCount: _repo.favorites.length,
                    itemBuilder: (context, index) {
                      return ProductTile(_repo.favorites[index]);
                    },
                  ),
          ),
          Container(
            height: 70,
            //color: Theme.of(context).primaryColor,
            color: const Color.fromARGB(255, 10, 73, 109),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "TOTAL:",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "\$ ${_repo.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
