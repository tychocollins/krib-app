import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krib/data/repositories/auth_repository.dart';
import 'package:krib/presentation/auth/login_screen.dart';
import 'package:krib/presentation/feed/feed_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const FeedScreen();
        } else {
          return const LoginScreen();
        }
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      ),
      error: (e, stack) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}
