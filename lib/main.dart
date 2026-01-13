import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:krib/core/theme/app_theme.dart';
import 'package:krib/presentation/auth/auth_gate.dart';
import 'package:krib/presentation/feed/feed_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart'; // Run flutterfire configure to generate this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('DEBUG: Failed to load .env from root: $e');
    try {
      await dotenv.load(fileName: "assets/.env");
    } catch (e) {
        print('DEBUG: Failed to load .env from assets: $e');
    }
  }

  try {
    // If you have generated firebase_options.dart, uncomment the import and the options line below.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, 
    );
    
    // Anonymous Auth for development
    await FirebaseAuth.instance.signInAnonymously();
    print("DEBUG: Signed in anonymously as ${FirebaseAuth.instance.currentUser?.uid}");
  } catch (e) {
     print("DEBUG: Firebase initialization failed (Expected if no config): $e");
  }

  runApp(const ProviderScope(child: KribApp()));
}

class KribApp extends StatelessWidget {
  const KribApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krib',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthGate(),
    );
  }
}
