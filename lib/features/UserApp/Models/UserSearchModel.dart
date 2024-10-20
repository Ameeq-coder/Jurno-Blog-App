class UserSearchModel {
  final String id;
  final String title;
  final String? imageUrl;
  final DateTime date;

  UserSearchModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.date,
  });

  // Factory method to create a model from JSON
  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      id: json['_id'],
      title: json['title'],
      imageUrl: json['featuredImage'],
      date: DateTime.parse(json['createdAt']),
    );
  }
}
