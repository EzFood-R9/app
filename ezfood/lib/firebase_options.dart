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
    apiKey: 'AIzaSyCOqdCh1o2UtuzrjCm83sHFObvUVKog5Qo',
    appId: '1:982526738318:web:77083707bb8367125faedf',
    messagingSenderId: '982526738318',
    projectId: 'ezfootesti',
    authDomain: 'ezfootesti.firebaseapp.com',
    storageBucket: 'ezfootesti.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNi_4SXNIYAn5Vr8tr2rM-ucDwqtM54Mk',
    appId: '1:982526738318:android:f4b758e232b4e23c5faedf',
    messagingSenderId: '982526738318',
    projectId: 'ezfootesti',
    storageBucket: 'ezfootesti.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuKTBJp_GET9txUcHxaqsHkZ3992y1pqs',
    appId: '1:982526738318:ios:b622df1d1500c7285faedf',
    messagingSenderId: '982526738318',
    projectId: 'ezfootesti',
    storageBucket: 'ezfootesti.appspot.com',
    iosClientId: '982526738318-drarglh2no53q225100m2bffqs87b1hu.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezfood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuKTBJp_GET9txUcHxaqsHkZ3992y1pqs',
    appId: '1:982526738318:ios:b622df1d1500c7285faedf',
    messagingSenderId: '982526738318',
    projectId: 'ezfootesti',
    storageBucket: 'ezfootesti.appspot.com',
    iosClientId: '982526738318-drarglh2no53q225100m2bffqs87b1hu.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezfood',
  );
}