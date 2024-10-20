import 'package:intl/intl.dart';


class UserPostsModel {
  final String id;
  final String title;
  final String content;
  final String imageUrl; // previously imageUrl, now it's featuredImage
  final DateTime date;  // Changed to DateTime to parse date
  final String? readTime; // optional since readTime is not provided in API

  UserPostsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
    this.readTime, // nullable as it's missing in the response
  });

  factory UserPostsModel.fromJson(Map<String, dynamic> json) {
    return UserPostsModel(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['featuredImage'], // map to 'featuredImage'
      date: DateTime.parse(json['createdAt']),  // Parse the date string
      readTime: json['readTime'] != null ? json['readTime'] : null, // handle null if it's not provided
    );
  }


  // Method to format the date
  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(date);
  }


}
