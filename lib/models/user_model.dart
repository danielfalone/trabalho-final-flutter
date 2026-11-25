class User {
  int? id;
  String name;
  String email;
  String password;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map map) => User(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    password: map['password'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
  };
}
