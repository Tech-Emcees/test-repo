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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDx7b1f8hYm2RwyRbPZe8NtfF9TF4h4oB4',
    appId: '1:231832411118:web:1defc7c7f5659d696dccff',
    messagingSenderId: '231832411118',
    projectId: 'tech-emcees-sih-2024',
    authDomain: 'tech-emcees-sih-2024.firebaseapp.com',
    storageBucket: 'tech-emcees-sih-2024.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBm5OcUOZ1aMzeL-WSFwWOSizTSqOMCpWg',
    appId: '1:231832411118:android:017aa300ad6796626dccff',
    messagingSenderId: '231832411118',
    projectId: 'tech-emcees-sih-2024',
    storageBucket: 'tech-emcees-sih-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLOgeh36XZfIhG2yyHI9cgbrXfi9bcOWA',
    appId: '1:231832411118:ios:a509f788a595f9d46dccff',
    messagingSenderId: '231832411118',
    projectId: 'tech-emcees-sih-2024',
    storageBucket: 'tech-emcees-sih-2024.appspot.com',
    iosBundleId: 'com.example.sih1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDx7b1f8hYm2RwyRbPZe8NtfF9TF4h4oB4',
    appId: '1:231832411118:web:4c793f6e7638e1266dccff',
    messagingSenderId: '231832411118',
    projectId: 'tech-emcees-sih-2024',
    authDomain: 'tech-emcees-sih-2024.firebaseapp.com',
    storageBucket: 'tech-emcees-sih-2024.appspot.com',
  );
}
