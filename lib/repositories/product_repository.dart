import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=50'),
    );
    List<Product> products = List<Product>.empty(growable: true);

    if (response.statusCode == 200) {
      Map<String, dynamic> resMap = jsonDecode(response.body);
      List resList = resMap["products"];

      resList.forEach((mProduct) {
        products.add(Product.fromJson(mProduct));
      });
    } else {
      throw Exception("Falha na conexão com o servidor!");
    }
    return products;
  }
}
