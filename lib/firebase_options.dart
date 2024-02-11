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
    apiKey: 'AIzaSyBoipK8_JxQvF3KA4N28YrSz3s8rJ5lEq0',
    appId: '1:440724346753:web:fe56c7eb59b62b7c783a80',
    messagingSenderId: '440724346753',
    projectId: 'flutter-netgo-app-bcfff',
    authDomain: 'flutter-netgo-app-bcfff.firebaseapp.com',
    storageBucket: 'flutter-netgo-app-bcfff.appspot.com',
    measurementId: 'G-M3ZRDN5C7E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIsPinei013LsrOGCxhPP3zMoVUysXNCk',
    appId: '1:440724346753:android:e6a4ceca5273b0ea783a80',
    messagingSenderId: '440724346753',
    projectId: 'flutter-netgo-app-bcfff',
    storageBucket: 'flutter-netgo-app-bcfff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdCc9fYwf_mRO8UV44RiTMX-4btZ8CLjE',
    appId: '1:440724346753:ios:537da2b5d03f1137783a80',
    messagingSenderId: '440724346753',
    projectId: 'flutter-netgo-app-bcfff',
    storageBucket: 'flutter-netgo-app-bcfff.appspot.com',
    iosBundleId: 'com.example.recursosHumanosNetgo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdCc9fYwf_mRO8UV44RiTMX-4btZ8CLjE',
    appId: '1:440724346753:ios:2d5ad5a769d3e929783a80',
    messagingSenderId: '440724346753',
    projectId: 'flutter-netgo-app-bcfff',
    storageBucket: 'flutter-netgo-app-bcfff.appspot.com',
    iosBundleId: 'com.example.recursosHumanosNetgo.RunnerTests',
  );
}