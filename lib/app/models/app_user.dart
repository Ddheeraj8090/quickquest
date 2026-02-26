class AppUser {
  const AppUser({
    required this.phone,
    required this.email,
  });

  final String phone;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
    };
  }

  factory AppUser.fromMap(Map<dynamic, dynamic> map) {
    return AppUser(
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String? ?? '',
    );
  }
}
