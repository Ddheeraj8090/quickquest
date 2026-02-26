import 'package:hive_flutter/hive_flutter.dart';

import '../models/app_user.dart';
import '../models/submission.dart';

class LocalStorageService {
  static const _boxName = 'quickquest_box';
  static const _currentUserKey = 'current_user';
  static const _usersKey = 'registered_users';
  static const _submissionsKey = 'submissions';

  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  AppUser? getCurrentUser() {
    final raw = _box.get(_currentUserKey);
    if (raw is Map) return AppUser.fromMap(raw);
    return null;
  }

  Future<void> saveCurrentUser(AppUser user) async {
    await _box.put(_currentUserKey, user.toMap());
  }

  Future<void> clearSession() async {
    await _box.delete(_currentUserKey);
  }

  List<Map<String, dynamic>> _getRegisteredUsers() {
    final raw = _box.get(_usersKey, defaultValue: <Map<String, dynamic>>[]);
    final list = (raw as List).map((e) => Map<String, dynamic>.from(e)).toList();
    return list;
  }

  Future<void> registerLocalUser({
    required String phone,
    required String password,
  }) async {
    final users = _getRegisteredUsers();
    final existing = users.where((u) => u['phone'] == phone).isNotEmpty;
    if (existing) {
      throw Exception('User already exists');
    }

    users.add({'phone': phone, 'password': password, 'email': _phoneToEmail(phone)});
    await _box.put(_usersKey, users);
  }

  AppUser loginLocalUser({
    required String phone,
    required String password,
  }) {
    final users = _getRegisteredUsers();
    final match = users.where((u) => u['phone'] == phone && u['password'] == password);
    if (match.isEmpty) {
      throw Exception('Invalid credentials');
    }
    return AppUser(phone: phone, email: _phoneToEmail(phone));
  }

  Future<void> saveSubmission(Submission submission) async {
    final raw = _box.get(_submissionsKey, defaultValue: <Map<String, dynamic>>[]);
    final list = (raw as List).map((e) => Map<String, dynamic>.from(e)).toList();
    list.add(submission.toMap());
    await _box.put(_submissionsKey, list);
  }

  List<Submission> getAllSubmissions() {
    final raw = _box.get(_submissionsKey, defaultValue: <Map<String, dynamic>>[]);
    final list = (raw as List)
        .map((e) => Submission.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    list.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
    return list;
  }

  String _phoneToEmail(String phone) => '$phone@quickquest.app';
}
