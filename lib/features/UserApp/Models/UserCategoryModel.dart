class UserCategoryModel {
  final String name;

  UserCategoryModel({required this.name});

  // Updated to handle both Map and String input
  factory UserCategoryModel.fromJson(dynamic json) {
    if (json is String) {
      return UserCategoryModel(name: json);
    } else if (json is Map<String, dynamic>) {
      return UserCategoryModel(name: json['name']);
    } else {
      throw Exception("Invalid category format");
    }
  }
}
