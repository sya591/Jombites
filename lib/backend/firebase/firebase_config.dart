import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBoLOqLCIMsPYNMEb9I0I54pp2QI2K99uE",
            authDomain: "helwa-bites-wj1gct.firebaseapp.com",
            projectId: "helwa-bites-wj1gct",
            storageBucket: "helwa-bites-wj1gct.appspot.com",
            messagingSenderId: "477756328055",
            appId: "1:477756328055:web:c8114634cd6fd30052de72",
            measurementId: "G-Z58S3ZNWCJ"));
  } else {
    await Firebase.initializeApp();
  }
}
