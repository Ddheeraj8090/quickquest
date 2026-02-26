import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
    Get.find<ProfileController>().refreshData();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.purple.shade300],
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
                    Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Obx(() => ListView(
                        padding: const EdgeInsets.all(20),
                        children: [
                          FadeTransition(
                            opacity: _animController,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.purple.shade300]),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [BoxShadow(color: Colors.blue.shade200, blurRadius: 15, offset: Offset(0, 8))],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.person, size: 50, color: Colors.blue.shade600),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    profileController.currentUser.value?.email ?? 'User',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '${profileController.submissions.length} Questionnaires Completed',
                                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Icon(Icons.history, color: Colors.grey.shade700, size: 20),
                              const SizedBox(width: 8),
                              Text('Submission History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (profileController.submissions.isEmpty)
                            Container(
                              padding: const EdgeInsets.all(40),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.assignment_outlined, size: 60, color: Colors.grey.shade300),
                                  const SizedBox(height: 12),
                                  Text('No submissions yet', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                          ...profileController.submissions.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return FadeTransition(
                              opacity: Tween<double>(begin: 0, end: 1).animate(
                                CurvedAnimation(
                                  parent: _animController,
                                  curve: Interval((index * 0.1).clamp(0, 1), 1, curve: Curves.easeOut),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(16),
                                  leading: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [Colors.blue.shade300, Colors.purple.shade200]),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(Icons.check_circle, color: Colors.white),
                                  ),
                                  title: Text(item.questionnaireTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                                          const SizedBox(width: 4),
                                          Text(DateFormat('dd MMM yyyy, hh:mm a').format(item.submittedAt), style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, size: 14, color: Colors.grey.shade600),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              'Lat: ${item.latitude.toStringAsFixed(5)}, Lng: ${item.longitude.toStringAsFixed(5)}',
                                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: authController.logout,
                            icon: Icon(Icons.logout),
                            label: Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 5,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
