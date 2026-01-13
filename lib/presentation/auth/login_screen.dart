import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/data/repositories/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true; // Toggle between Login and Sign Up
  bool _isLoading = false;

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        await ref.read(authRepositoryProvider).signInWithEmailAndPassword(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      } else {
        await ref.read(authRepositoryProvider).createUserWithEmailAndPassword(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _guestLogin() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInAnonymously();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or App Name
              Text(
                'KRIB',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 8.0,
                ),
              ),
              const SizedBox(height: 48),

              // Title
              Text(
                _isLogin ? 'Welcome Back' : 'Create Account',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),

              // Input Fields
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Email', Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Password', Icons.lock_outline),
              ),
              const SizedBox(height: 32),

              // Main Action Button
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                    : Text(
                        _isLogin ? 'Sign In' : 'Sign Up',
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              
              const SizedBox(height: 16),
              
              // Toggle Button
              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                  _isLogin ? 'Don\'t have an account? Sign Up' : 'Already have an account? Sign In',
                   style: GoogleFonts.outfit(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 32),
              const Divider(color: Colors.white24),
              const SizedBox(height: 32),

              // Guest Button
              OutlinedButton(
                onPressed: _isLoading ? null : _guestLogin,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white24),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Continue as Guest',
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white54),
      ),
    );
  }
}
