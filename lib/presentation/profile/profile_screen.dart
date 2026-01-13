import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/data/repositories/auth_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.watch(authRepositoryProvider);
    final user = authRepo.currentUser;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white10,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 24),
            
            Text(
              user?.isAnonymous == true ? 'Guest User' : (user?.email ?? 'Unknown User'),
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'UID: ${user?.uid.substring(0, 8)}...',
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.white54,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(authRepositoryProvider).signOut();
                  // AuthGate will handle the redirect
                  Navigator.pop(context); // Close profile if pushed
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
