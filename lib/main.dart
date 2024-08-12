import 'package:fashion_project/Provider/favourite_provider.dart';
import 'package:fashion_project/bottomnavigationbar.dart';
import 'package:fashion_project/firebase_options.dart';
import 'package:fashion_project/screens/cartmodel.dart';
import 'package:fashion_project/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    seen: seen,
  ));
}

class MyApp extends StatelessWidget {
  final bool seen;

  const MyApp({
    super.key,
    required this.seen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: seen ? const BottomNavigationbarScreen() : const SplashScreen(),
      ),
    );
  }
}
