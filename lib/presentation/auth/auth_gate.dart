import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krib/data/providers/location_provider.dart';
import 'package:krib/data/repositories/auth_repository.dart';
import 'package:krib/presentation/auth/login_screen.dart';
import 'package:krib/presentation/feed/feed_screen.dart';
import 'package:krib/presentation/location/location_selection_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Check Authentication State
    final authState = ref.watch(authStateChangesProvider);
    // 2. Check Location Selection State
    final locationState = ref.watch(locationProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          // Not logged in -> Show Login
          return const LoginScreen();
        } else {
          // Logged in -> Check Location
          if (!locationState.isSet) {
             // Location not set -> Show Selection
            return const LocationSelectionScreen();
          }
          // Both Auth & Location set -> Show Feed
          return const FeedScreen();
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
