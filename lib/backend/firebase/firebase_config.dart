import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBcnRKZAmOvbbWWl9tzXwfaWuz5q7iLTB4",
            authDomain: "application-9b5e8.firebaseapp.com",
            projectId: "application-9b5e8",
            storageBucket: "application-9b5e8.firebasestorage.app",
            messagingSenderId: "498314599101",
            appId: "1:498314599101:web:588fe4414d12e2499935d4",
            measurementId: "G-E2Y1BMY4KP"));
  } else {
    await Firebase.initializeApp();
  }
}
