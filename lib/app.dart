import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

class QuickQuestApp extends StatelessWidget {
  const QuickQuestApp({super.key, required this.initialLoggedIn});

  final bool initialLoggedIn;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QuickQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.grey.shade900,
          contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      initialRoute: initialLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
