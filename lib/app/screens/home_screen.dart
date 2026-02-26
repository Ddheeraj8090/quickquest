import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/questionnaire.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 16, 20, 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.purple.shade300],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.quiz, color: Colors.blue.shade600, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('QuickQuest', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Choose a questionnaire', style: TextStyle(fontSize: 14, color: Colors.white70)),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => Get.toNamed(AppRoutes.profile),
                      icon: Icon(Icons.person, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => controller.questionnaires.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox, size: 80, color: Colors.grey.shade300),
                          const SizedBox(height: 16),
                          Text('No questionnaires available', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: controller.questionnaires.length,
                      itemBuilder: (_, index) {
                        final Questionnaire item = controller.questionnaires[index];
                        return FadeTransition(
                          opacity: Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _animController,
                              curve: Interval((index * 0.1).clamp(0, 1), 1, curve: Curves.easeOut),
                            ),
                          ),
                          child: SlideTransition(
                            position: Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
                              CurvedAnimation(
                                parent: _animController,
                                curve: Interval((index * 0.1).clamp(0, 1), 1, curve: Curves.easeOut),
                              ),
                            ),
                            child: _QuestionnaireCard(item: item, index: index),
                          ),
                        );
                      },
                    )),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionnaireCard extends StatelessWidget {
  const _QuestionnaireCard({required this.item, required this.index});

  final Questionnaire item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      [Colors.blue.shade400, Colors.blue.shade600],
      [Colors.purple.shade400, Colors.purple.shade600],
      [Colors.orange.shade400, Colors.orange.shade600],
      [Colors.teal.shade400, Colors.teal.shade600],
      [Colors.pink.shade400, Colors.pink.shade600],
    ];
    final colorPair = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colorPair),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: colorPair[1].withOpacity(0.3), blurRadius: 12, offset: Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.toNamed(AppRoutes.questionnaire, arguments: item),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.assignment, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(item.description, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9))),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${item.questions.length} Questions', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
