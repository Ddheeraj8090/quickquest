import 'package:get/get.dart';

import '../models/questionnaire.dart';
import '../services/questionnaire_service.dart';

class HomeController extends GetxController {
  HomeController({required this.questionnaireService});

  final QuestionnaireService questionnaireService;
  final questionnaires = <Questionnaire>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestionnaires();
  }

  void loadQuestionnaires() {
    questionnaires.assignAll(questionnaireService.fetchQuestionnaires());
  }

  Questionnaire? byId(String id) {
    try {
      return questionnaires.firstWhere((element) => element.id == id);
    } catch (_) {
      return null;
    }
  }
}
