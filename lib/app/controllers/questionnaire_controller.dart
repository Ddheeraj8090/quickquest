import 'package:get/get.dart';

import '../models/questionnaire.dart';
import '../models/submission.dart';
import '../routes/app_routes.dart';
import '../services/local_storage_service.dart';
import '../services/location_service.dart';

class QuestionnaireController extends GetxController {
  QuestionnaireController({
    required this.localStorage,
    required this.locationService,
  });

  final LocalStorageService localStorage;
  final LocationService locationService;

  final RxMap<String, int> selected = <String, int>{}.obs;
  final RxBool submitting = false.obs;
  late Questionnaire questionnaire;

  @override
  void onInit() {
    super.onInit();
    questionnaire = Get.arguments as Questionnaire;
  }

  void selectOption(String questionId, int optionIndex) {
    selected[questionId] = optionIndex;
  }

  bool get allAnswered => selected.length == questionnaire.questions.length;

  Future<void> submit() async {
    if (!allAnswered) {
      Get.snackbar('Validation', 'Please answer all questions');
      return;
    }

    submitting.value = true;
    try {
      final latLong = await locationService.getLatLong();
      final submission = Submission(
        questionnaireId: questionnaire.id,
        questionnaireTitle: questionnaire.title,
        answers: Map<String, int>.from(selected),
        submittedAt: DateTime.now(),
        latitude: latLong.latitude,
        longitude: latLong.longitude,
      );
      await localStorage.saveSubmission(submission);
      Get.snackbar('Success', 'Questionnaire submitted successfully');
      Get.offAllNamed(AppRoutes.home);
    } finally {
      submitting.value = false;
    }
  }
}
