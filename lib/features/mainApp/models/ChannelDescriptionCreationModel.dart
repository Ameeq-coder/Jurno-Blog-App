class ChannelDescriptionCreationModel {
  String? channelDescription;
  String? channelImage;

  ChannelDescriptionCreationModel({this.channelDescription, this.channelImage});

  factory ChannelDescriptionCreationModel.fromJson(Map<String, dynamic> json) {
    return ChannelDescriptionCreationModel(
      channelDescription: json['channelDescription'],
      channelImage: json['channelImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channelDescription': channelDescription,
      'channelImage': channelImage,
    };
  }
}
