import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../repositories/favorites_repository.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            margin: EdgeInsets.all(10),
            child: Image.network(product.thumbnail),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: TextStyle(fontSize: 18)),
                Text(
                  "\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Consumer<FavoritesRepository>(
            builder: (context, repo, child) {
              return IconButton(
                icon: Icon(
                  repo.isFavorite(product)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                color: repo.isFavorite(product)
                    ? Colors.red
                    : Theme.of(context).primaryColor,
                onPressed: () {
                  if (repo.isFavorite(product)) {
                    repo.remove(product);
                  } else {
                    repo.add(product);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
