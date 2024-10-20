class User{
  final String email;
  final String password;
  final String confirmpass;
  User({required this.email, required this.password, required this.confirmpass});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmpass' : confirmpass
    };
  }
}