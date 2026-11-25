class Product {
  int id;
  String title;
  double price;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"].toDouble(),
    thumbnail: json["thumbnail"],
  );

  factory Product.fromMap(Map map) => Product(
    id: map['productId'],
    title: map['title'],
    price: map['price'],
    thumbnail: map['thumbnail'],
  );

  Map<String, dynamic> toMap() => {
    'productId': id,
    'title': title,
    'price': price,
    'thumbnail': thumbnail,
  };
}
