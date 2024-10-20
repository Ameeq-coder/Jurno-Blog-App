import 'package:intl/intl.dart';

class DownloadModel {
  final String id;
  final String imageUrl;
  final String title;
  final DateTime date;

  DownloadModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.date,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(
      id: json['postId'],
      imageUrl: json['featuredImage'],
      title: json['title'],
      date: DateTime.parse(json['downloadedAt']),  // Parse date
    );
  }

  String get formattedDate {
    return DateFormat('dd MMM yyyy').format(date);
  }

}
