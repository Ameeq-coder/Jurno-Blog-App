import 'dart:convert';

class TagAddModel{
  final String tag;
  final String slug;

  TagAddModel({required this.tag, required this.slug});

  factory TagAddModel.fromJson(Map<String, dynamic> json) {
    return TagAddModel(
      tag: json['tag'],
      slug: json['slug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'slug': slug,
    };
  }

}