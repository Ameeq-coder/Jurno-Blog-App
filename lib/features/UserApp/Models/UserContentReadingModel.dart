import 'package:intl/intl.dart';

class UserContentReadingModel {
  final String title;
  final String content;
  final String imageUrl;
  final DateTime date;
  final String channelName;
  final int views; // Include views field

  UserContentReadingModel({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.channelName,
    required this.views,
  });

  // Factory method to create model from JSON
  factory UserContentReadingModel.fromJson(Map<String, dynamic> json) {
    return UserContentReadingModel(
      title: json['title'],
      content: json['content'],
      imageUrl: json['featuredImage'],  // Adjust based on the actual API response
      date: DateTime.parse(json['createdAt']),  // Parse date
      channelName: json['channelName'],  // Parse channel name
      views: json['views'],  // Parse views count
    );
  }
}
