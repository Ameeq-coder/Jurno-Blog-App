class ChannelImageModel {
  final String? channelDescription;
  final String? channelImage;

  ChannelImageModel({this.channelDescription, this.channelImage});

  // A factory method to parse the API response JSON
  factory ChannelImageModel.fromJson(Map<String, dynamic> json) {
    return ChannelImageModel(
      channelDescription: json['channelDescription'],
      channelImage: json['channelImage'],
    );
  }
}
