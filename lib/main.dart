import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'app/controllers/auth_controller.dart';
import 'app/controllers/home_controller.dart';
import 'app/controllers/profile_controller.dart';
import 'app/services/auth_service.dart';
import 'app/services/firebase_service.dart';
import 'app/services/local_storage_service.dart';
import 'app/services/location_service.dart';
import 'app/services/questionnaire_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('[Main] App bootstrap started');

  await FirebaseService.instance.init();
  debugPrint('[Main] Firebase init status: ${FirebaseService.instance.isInitialized}');

  final localStorage = Get.put(LocalStorageService(), permanent: true);
  await localStorage.init();
  debugPrint('[Main] Local storage initialized');

  Get.put(
    AuthService(
      localStorage: localStorage,
      firebaseService: FirebaseService.instance,
    ),
    permanent: true,
  );

  Get.lazyPut(() => QuestionnaireService(), fenix: true);
  Get.lazyPut(() => LocationService(), fenix: true);

  final hasSession = localStorage.getCurrentUser() != null;
  debugPrint('[Main] runApp with hasSession=$hasSession');
  runApp(QuickQuestApp(initialLoggedIn: hasSession));
}
