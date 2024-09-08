

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform,TargetPlatform, kIsWeb;


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
    apiKey: 'AIzaSyBHp7AfM9XuG2TdjPe-gj4zWkDBFxyAAHY',
    appId: '1:387484227628:web:e087079e228cfa54ee9989',
    messagingSenderId: '387484227628',
    projectId: 'movies-35a67',
    authDomain: 'movies-35a67.firebaseapp.com',
    storageBucket: 'movies-35a67.appspot.com',
    measurementId: 'G-CYSL5RQW08',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAC8ewtRK0VLXXYa3tyIE4YyOrOd_0rp20',
    appId: '1:387484227628:android:dbd10b75ca78e998ee9989',
    messagingSenderId: '387484227628',
    projectId: 'movies-35a67',
    storageBucket: 'movies-35a67.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmHZDozR7G7UUSiZvLQldjDqbcC_fp70E',
    appId: '1:387484227628:ios:8fa5ced59d59cc9bee9989',
    messagingSenderId: '387484227628',
    projectId: 'movies-35a67',
    storageBucket: 'movies-35a67.appspot.com',
    iosBundleId: 'com.example.moviesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmHZDozR7G7UUSiZvLQldjDqbcC_fp70E',
    appId: '1:387484227628:ios:099b881c28389872ee9989',
    messagingSenderId: '387484227628',
    projectId: 'movies-35a67',
    storageBucket: 'movies-35a67.appspot.com',
    iosBundleId: 'com.example.moviesApp.RunnerTests',
  );
}
