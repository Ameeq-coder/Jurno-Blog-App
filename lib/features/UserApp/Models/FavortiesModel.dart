import 'package:intl/intl.dart';

class FavoriteModel {
  final String id;
  final String imageUrl;
  final String title;
  // final DateTime date;



  FavoriteModel({required this.id, required this.imageUrl, required this.title});

  // A factory constructor to create a FavoritePost from JSON
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'], // Assuming your API returns an _id field
      imageUrl: json['featuredImage'],
      title: json['title'],
      // date: DateTime.parse(json['downloadedAt']),  // Parse date
    );
  }



}
