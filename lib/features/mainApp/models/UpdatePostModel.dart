class UpdatePostModel {
  final String id;
  final String title;
  final String slug;
  final List<String> tags;
  final List<String> categories;
  final String content;
  final String? featuredImage;

  UpdatePostModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.tags,
    required this.categories,
    required this.content,
    this.featuredImage,
  });

  factory UpdatePostModel.fromJson(Map<String, dynamic> json) {
    return UpdatePostModel(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      tags: List<String>.from(json['tags']),
      categories: List<String>.from(json['categories']),
      content: json['content'],
      featuredImage: json['featuredImage'],
    );
  }
}
