import 'package:flutter/material.dart';
import 'package:module4/profile.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyB9GWvEoFb9eGcfAvMlnwpbCED6R1BQhI0",

        authDomain: "boitumelo-motsoari-module-5.firebaseapp.com",

        projectId: "boitumelo-motsoari-module-5",

        storageBucket: "boitumelo-motsoari-module-5.appspot.com",

        messagingSenderId: "474808205954",

        appId: "1:474808205954:web:35202ea768908a1e272a9b"
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}

class splash extends StatelessWidget {
  const splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/108216-flower-animation.json'),
      nextScreen: profile(),
      backgroundColor: Colors.grey,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
