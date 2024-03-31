// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBSDZ9ea_k3IV6QQIsQkEzWeGpemxCoinA',
    appId: '1:866869984029:web:655bddca2f9d3cef837ff4',
    messagingSenderId: '866869984029',
    projectId: 'chat-app-f4afb',
    authDomain: 'chat-app-f4afb.firebaseapp.com',
    storageBucket: 'chat-app-f4afb.appspot.com',
    measurementId: 'G-H76J8BHRM7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBS-oK-En1vE68tQ2Wvw4xgRgj5WPYfc-k',
    appId: '1:866869984029:android:ec4fbbbb536bd749837ff4',
    messagingSenderId: '866869984029',
    projectId: 'chat-app-f4afb',
    storageBucket: 'chat-app-f4afb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSXtabopHyr5r1LopcFVhDkq-TsL0jN_M',
    appId: '1:866869984029:ios:7b3234b5fe965649837ff4',
    messagingSenderId: '866869984029',
    projectId: 'chat-app-f4afb',
    storageBucket: 'chat-app-f4afb.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBSXtabopHyr5r1LopcFVhDkq-TsL0jN_M',
    appId: '1:866869984029:ios:21983dd32f67b3c8837ff4',
    messagingSenderId: '866869984029',
    projectId: 'chat-app-f4afb',
    storageBucket: 'chat-app-f4afb.appspot.com',
    iosBundleId: 'com.example.chatApp.RunnerTests',
  );
}