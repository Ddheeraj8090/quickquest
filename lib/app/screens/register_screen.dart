import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Curves.easeIn));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple.shade300, Colors.blue.shade400],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                            ),
                            child: Icon(Icons.person_add, size: 60, color: Colors.purple.shade600),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('Sign up to get started', style: TextStyle(fontSize: 16, color: Colors.white70)),
                        const SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))],
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone, color: Colors.purple.shade600),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.purple.shade600, width: 2)),
                                ),
                                validator: (v) => (v == null || v.trim().isEmpty) ? 'Phone is required' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock, color: Colors.purple.shade600),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.purple.shade600, width: 2)),
                                ),
                                validator: (v) => (v == null || v.length < 6) ? 'Min 6 characters required' : null,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _confirmController,
                                obscureText: _obscureConfirm,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock_outline, color: Colors.purple.shade600),
                                  suffixIcon: IconButton(
                                    icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.purple.shade600, width: 2)),
                                ),
                                validator: (v) => (v != _passwordController.text) ? 'Passwords do not match' : null,
                              ),
                              const SizedBox(height: 24),
                              Obx(() => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: authController.loading.value ? null : () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      authController.register(
                                        phone: _phoneController.text.trim(),
                                        password: _passwordController.text,
                                        confirmPassword: _confirmController.text,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple.shade600,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 5,
                                  ),
                                  child: authController.loading.value
                                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                      : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ),
                              )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? ', style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
