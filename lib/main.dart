import 'package:flutter/material.dart';
import 'package:inventory_management/screens/authenticate/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/logo.png',
          height: 500,
          width: 500,
          scale: 0.8,
        ),
        nextScreen: Login(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.lightBlue[300],
        duration: 2000,
      ),
    );
  }
}

// title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: Login(),
