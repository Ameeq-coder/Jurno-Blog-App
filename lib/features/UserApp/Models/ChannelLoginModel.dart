class ChannelLoginModel{

  final String channelName;

  final String password;


  ChannelLoginModel({
    required this.channelName,
    required this.password,
  });


  Map<String, dynamic> toJson() {
    return {
      'channelName': channelName,
      'password': password
    };
  }

  }
