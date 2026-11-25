import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'repositories/auth_repository.dart';
import 'repositories/favorites_repository.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthRepository()),
        ChangeNotifierProvider(create: (context) => FavoritesRepository()),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 56, 182, 236),
          ),
          //visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
