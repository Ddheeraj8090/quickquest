import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/questionnaire_controller.dart';
import '../models/questionnaire.dart';
import '../services/local_storage_service.dart';
import '../services/location_service.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> with SingleTickerProviderStateMixin {
  late final QuestionnaireController controller;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
    controller = Get.put(
      QuestionnaireController(
        localStorage: Get.find<LocalStorageService>(),
        locationService: Get.find<LocationService>(),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    Get.delete<QuestionnaireController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Questionnaire questionnaire = controller.questionnaire;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade400, Colors.blue.shade300],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(questionnaire.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('${questionnaire.questions.length} Questions', style: TextStyle(fontSize: 14, color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: questionnaire.questions.length,
                        itemBuilder: (_, index) {
                          final question = questionnaire.questions[index];
                          return FadeTransition(
                            opacity: Tween<double>(begin: 0, end: 1).animate(
                              CurvedAnimation(
                                parent: _animController,
                                curve: Interval((index * 0.1).clamp(0, 1), 1, curve: Curves.easeOut),
                              ),
                            ),
                            child: Obx(() => _QuestionCard(
                              index: index,
                              question: question,
                              selectedIndex: controller.selected[question.id],
                              onSelected: (optionIndex) => controller.selectOption(question.id, optionIndex),
                            )),
                          );
                        },
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
                ),
                child: Obx(() => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.submitting.value ? null : controller.submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade500,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 5,
                        ),
                        child: controller.submitting.value
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle),
                                  const SizedBox(width: 8),
                                  Text('Submit Answers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.question,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int index;
  final Question question;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.teal.shade400, Colors.blue.shade300]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('${index + 1}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    question.text,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...List.generate(
              question.options.length,
              (optionIndex) => GestureDetector(
                onTap: () => onSelected(optionIndex),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedIndex == optionIndex ? Colors.teal.shade50 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedIndex == optionIndex ? Colors.teal.shade400 : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedIndex == optionIndex ? Colors.teal.shade400 : Colors.grey.shade400,
                            width: 2,
                          ),
                          color: selectedIndex == optionIndex ? Colors.teal.shade400 : Colors.transparent,
                        ),
                        child: selectedIndex == optionIndex ? Icon(Icons.check, size: 16, color: Colors.white) : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question.options[optionIndex],
                          style: TextStyle(
                            fontSize: 15,
                            color: selectedIndex == optionIndex ? Colors.teal.shade700 : Colors.grey.shade700,
                            fontWeight: selectedIndex == optionIndex ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
