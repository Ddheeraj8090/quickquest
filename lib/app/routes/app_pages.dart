import 'package:get/get.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/questionnaire_screen.dart';
import '../screens/register_screen.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(authService: Get.find<AuthService>()));
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(authService: Get.find<AuthService>()));
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController(questionnaireService: Get.find()));
      }),
    ),
    GetPage(
      name: AppRoutes.questionnaire,
      page: () => const QuestionnaireScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AuthController(authService: Get.find<AuthService>()));
        Get.lazyPut(() => ProfileController(localStorage: Get.find<LocalStorageService>()));
      }),
    ),
  ];
}
