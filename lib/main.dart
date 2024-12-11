import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:reddrop/splash/splash.dart';

const SAVE_KEY_NAME = "userLoggedin";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      // Web Firebase initialization
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyC1h6rWYeSi-9oT7apAZoJWMvMpOGEpSi4",
          authDomain: "reddrop1-f1c8c.firebaseapp.com",
          projectId: "reddrop1-f1c8c",
          storageBucket: "reddrop1-f1c8c.appspot.com",
          messagingSenderId: "765692546365",
          appId: "1:765692546365:web:8253f61fbbdaf02a2a8954",
          measurementId: "G-ZKG1XFP8DP",
        ),
      );
    } else {
      // Mobile Firebase initialization
      await Firebase.initializeApp();
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(),
      ),
      home: const Splash(),
    );
  }
}
