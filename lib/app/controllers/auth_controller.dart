import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/app_user.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class AuthController extends GetxController {
  AuthController({required this.authService});

  final AuthService authService;

  final Rxn<AppUser> currentUser = Rxn<AppUser>();
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    currentUser.value = Get.find<LocalStorageService>().getCurrentUser();
  }

  Future<void> register({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    if (!_validatePhone(phone)) {
      Get.snackbar('Validation', 'Enter valid phone (min 10 digits)');
      return;
    }
    if (password.length < 6) {
      Get.snackbar('Validation', 'Password must be at least 6 characters');
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar('Validation', 'Password and confirm password do not match');
      return;
    }

    loading.value = true;
    try {
      await authService.register(phone: phone, password: password);
      Get.snackbar('Success', 'Registration successful, please login');
      Get.offNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Register Failed', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      loading.value = false;
    }
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    if (!_validatePhone(phone) || password.isEmpty) {
      Get.snackbar('Validation', 'Phone and password are required');
      return;
    }

    loading.value = true;
    try {
      final user = await authService.login(phone: phone, password: password);
      currentUser.value = user;
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Login Failed', e.toString().replaceFirst('Exception: ', ''));
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout, color: Colors.red.shade400),
            const SizedBox(width: 8),
            const Text('Logout'),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    if (result == true) {
      await authService.logout();
      currentUser.value = null;
      Get.offAllNamed(AppRoutes.login);
    }
  }

  bool _validatePhone(String value) {
    final clean = value.replaceAll(RegExp(r'\D'), '');
    return clean.length >= 10;
  }
}
