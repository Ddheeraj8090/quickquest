import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  bool isInitialized = false;

  Future<void> init() async {
    try {
      await Firebase.initializeApp().timeout(const Duration(seconds: 8));
      isInitialized = true;
      debugPrint('[FirebaseService] Firebase initialized');
    } catch (e, st) {
      isInitialized = false;
      debugPrint('[FirebaseService] Firebase init failed: $e');
      debugPrint('$st');
    }
  }
}
