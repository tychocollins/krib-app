import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Abstract Interface
abstract class FavoritesRepository {
  Future<void> addFavorite(String propertyId);
  Future<void> removeFavorite(String propertyId);
  Stream<List<String>> watchFavorites();
}

// Provider
final favoritesProvider = Provider<FavoritesRepository>((ref) {
  // defaulting to Mock for now since firebase_options.dart is missing.
  // In the future, check a config flag or environment variable.
  // return MockFavoritesRepository();
  return FirebaseFavoritesRepository(); // Uncomment when Firebase is configured
});

// Mock Implementation (In-Memory)
class MockFavoritesRepository implements FavoritesRepository {
  final List<String> _favorites = []; // Local cache
  // Using a simple broadcast stream for the mock
  // In a real app we'd use a BehaviorSubject or StreamController
  // but for simplicity we'll just yield the list on changes if we could, 
  // but implementing a proper stream for a list variable is tricky without StreamController.
  // Let's use a simple StateProvider logic or just return a Stream.periodic/value.
  // Actually, easiest way to mock a stream is using a StreamController.
  
  // Actually, let's keep it simple. Mock repo usually updates a BehaviorSubject.
  // For now, I will just log and return a static stream or use a simplified approach.
  
  @override
  Future<void> addFavorite(String propertyId) async {
    if (!_favorites.contains(propertyId)) {
      _favorites.add(propertyId);
      print('MOCK DB: Added favorite $propertyId. Total: ${_favorites.length}');
    }
  }

  @override
  Future<void> removeFavorite(String propertyId) async {
    _favorites.remove(propertyId);
     print('MOCK DB: Removed favorite $propertyId. Total: ${_favorites.length}');
  }

  @override
  Stream<List<String>> watchFavorites() {
    // Return a stream that emits the current list every time it's asked?
    // A real stream receives updates.
    // For this Mock, let's just emit the current list once.
    // To support real-time updates in the UI with the Mock, we need a StreamController.
    return Stream.value(_favorites); 
    // Note: This won't refresh the UI automatically on add/remove in the Mock version 
    // unless we use a StreamController, but it's enough to test the initial load 
    // or we can implement a proper StreamController if needed.
  }
}

// Real Implementation
class FirebaseFavoritesRepository implements FavoritesRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get _userId => _auth.currentUser?.uid;

  @override
  Future<void> addFavorite(String propertyId) async {
    final uid = _userId;
    if (uid == null) {
      print("ERROR: No user logged in during addFavorite.");
      return;
    }
    
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(propertyId)
          .set({'likedAt': FieldValue.serverTimestamp()});
    } catch (e) {
      print("ERROR: Failed to write to Firestore: $e");
    }
  }

  @override
  Future<void> removeFavorite(String propertyId) async {
    final uid = _userId;
    if (uid == null) return;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(propertyId)
        .delete();
  }

  @override
  Stream<List<String>> watchFavorites() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toList();
    });
  }
}
