import 'package:firebase_auth/firebase_auth.dart';

import '../models/app_user.dart';
import 'firebase_service.dart';
import 'local_storage_service.dart';

class AuthService {
  const AuthService({
    required this.localStorage,
    required this.firebaseService,
  });

  final LocalStorageService localStorage;
  final FirebaseService firebaseService;

  String _phoneToEmail(String phone) => '$phone@quickquest.app';

  Future<void> register({
    required String phone,
    required String password,
  }) async {
    if (firebaseService.isInitialized) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _phoneToEmail(phone),
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code != 'email-already-in-use') {
          rethrow;
        }
      }
    }

    await localStorage.registerLocalUser(phone: phone, password: password);
  }

  Future<AppUser> login({
    required String phone,
    required String password,
  }) async {
    if (firebaseService.isInitialized) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _phoneToEmail(phone),
          password: password,
        );
      } on FirebaseAuthException {
        // Keep local auth available for assignment flow.
      }
    }

    final user = localStorage.loginLocalUser(phone: phone, password: password);
    await localStorage.saveCurrentUser(user);
    return user;
  }

  Future<void> logout() async {
    if (firebaseService.isInitialized) {
      await FirebaseAuth.instance.signOut();
    }
    await localStorage.clearSession();
  }
}
