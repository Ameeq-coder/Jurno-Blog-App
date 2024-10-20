class UserEmail {
  final String email;

  UserEmail({ required this.email});

  // Factory method to create User object from JSON
  factory UserEmail.fromJson(Map<String, dynamic> json) {
    return UserEmail(
      email: json['email'],
    );
  }
}
