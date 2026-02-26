import 'package:get/get.dart';

import '../models/app_user.dart';
import '../models/submission.dart';
import '../services/local_storage_service.dart';

class ProfileController extends GetxController {
  ProfileController({required this.localStorage});

  final LocalStorageService localStorage;

  final Rxn<AppUser> currentUser = Rxn<AppUser>();
  final submissions = <Submission>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshData();
  }

  void refreshData() {
    currentUser.value = localStorage.getCurrentUser();
    submissions.assignAll(localStorage.getAllSubmissions());
  }
}
