class LoginModel{
  final String token;
  final String msg;

  LoginModel({required this.token, required this.msg});


  factory LoginModel.fromJson(Map<String,dynamic> json){
    return LoginModel(
      token: json['token'],
      msg: json['msg'],
    );
  }
}


