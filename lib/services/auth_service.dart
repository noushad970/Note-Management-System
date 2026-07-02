import 'package:firebase_auth/firebase_auth.dart';

/// Wraps FirebaseAuth with the project's anonymous-login flow.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Stream of authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// The currently signed-in user, or null.
  User? get currentUser => _auth.currentUser;

  /// Convenience getter for the current user's UID.
  String? get currentUserId => _auth.currentUser?.uid;

  /// Sign in anonymously. Returns the signed-in [User].
  Future<User?> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    return credential.user;
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
