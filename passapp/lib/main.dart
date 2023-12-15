import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:passapp/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = Hive.openBox("Users");
  var Passwords = Hive.openBox("Passwords");
  var Platforms = Hive.openBox("Platforms");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}
