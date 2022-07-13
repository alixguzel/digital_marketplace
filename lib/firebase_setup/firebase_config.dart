import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions? get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
          apiKey: "AIzaSyC9HiG3-WHPy7REPYUq64GegxQSQ3PB4j0",
          authDomain: "usus-611b4.firebaseapp.com",
          databaseURL: "https://usus-611b4-default-rtdb.firebaseio.com",
          projectId: "usus-611b4",
          storageBucket: "usus-611b4.appspot.com",
          messagingSenderId: "929354417131",
          appId: "1:929354417131:web:f57ca0f42bdf01b0d30fae",
          measurementId: "G-S1CWVSEGQF");
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:448618578101:ios:cc6c1dc7a65cc83c',
        apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
        projectId: 'react-native-firebase-testing',
        messagingSenderId: '448618578101',
        iosBundleId: 'com.invertase.testing',
        iosClientId:
            '448618578101-28tsenal97nceuij1msj7iuqinv48t02.apps.googleusercontent.com',
        androidClientId:
            '448618578101-a9p7bj5jlakabp22fo3cbkj7nsmag24e.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        storageBucket: 'react-native-firebase-testing.appspot.com',
      );
    } else {
      // Android
      log("Analytics Dart-only initializer doesn't work on Android, please make sure to add the config file.");

      return null;
    }
  }
}
