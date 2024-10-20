class ChannelSignupModel {

  String channelName;
  String password;

  ChannelSignupModel({required this.channelName, required this.password});


  Map<String, dynamic> toJson() {
    return {
      "channelName": channelName,
      "password": password,
    };
  }






}