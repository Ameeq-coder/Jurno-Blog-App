class ChannelNameModel {
  final String channelName;

  ChannelNameModel({required this.channelName});

  factory ChannelNameModel.fromJson(Map<String, dynamic> json) {
    return ChannelNameModel(
      channelName: json['channelName'],
    );
  }
}
