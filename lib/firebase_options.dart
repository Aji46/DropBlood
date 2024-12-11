// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC1h6rWYeSi-9oT7apAZoJWMvMpOGEpSi4',
    appId: '1:765692546365:web:8253f61fbbdaf02a2a8954',
    messagingSenderId: '765692546365',
    projectId: 'reddrop1-f1c8c',
    authDomain: 'reddrop1-f1c8c.firebaseapp.com',
    storageBucket: 'reddrop1-f1c8c.appspot.com',
    measurementId: 'G-ZKG1XFP8DP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgEyusQUYHrPo-bobqWZBM6XlVfXR1lo8',
    appId: '1:765692546365:android:4e69d89b94859dd62a8954',
    messagingSenderId: '765692546365',
    projectId: 'reddrop1-f1c8c',
    storageBucket: 'reddrop1-f1c8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOED1_GgY48ayKv-P41xGB7bPTOztBUtQ',
    appId: '1:765692546365:ios:0ef13b09e3cd4ebc2a8954',
    messagingSenderId: '765692546365',
    projectId: 'reddrop1-f1c8c',
    storageBucket: 'reddrop1-f1c8c.appspot.com',
    iosBundleId: 'com.example.reddrop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOED1_GgY48ayKv-P41xGB7bPTOztBUtQ',
    appId: '1:765692546365:ios:0ef13b09e3cd4ebc2a8954',
    messagingSenderId: '765692546365',
    projectId: 'reddrop1-f1c8c',
    storageBucket: 'reddrop1-f1c8c.appspot.com',
    iosBundleId: 'com.example.reddrop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC1h6rWYeSi-9oT7apAZoJWMvMpOGEpSi4',
    appId: '1:765692546365:web:2077a9049fc9d41c2a8954',
    messagingSenderId: '765692546365',
    projectId: 'reddrop1-f1c8c',
    authDomain: 'reddrop1-f1c8c.firebaseapp.com',
    storageBucket: 'reddrop1-f1c8c.appspot.com',
    measurementId: 'G-M6WEFX9YM7',
  );
}
