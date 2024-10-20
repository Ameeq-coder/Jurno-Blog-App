import 'dart:convert';

class BlogCategoryAddModel {
  final String blogcategory;
  final String slug;

  BlogCategoryAddModel({required this.blogcategory, required this.slug});

  factory BlogCategoryAddModel.fromJson(Map<String, dynamic> json) {
    return BlogCategoryAddModel(
      blogcategory: json['blogcategory'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blogcategory': blogcategory,
      'slug': slug,
    };
  }
}
