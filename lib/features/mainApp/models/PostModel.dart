class PostModel {
  String userId;
  String title;
  String slug;
  List<String> categories;
  List<String> tags;
  String content;
  String featuredImage;


PostModel({
  required this.userId,
  required this.title,
  required this.slug,
  required this.categories,
  required this.tags,
  required this.content,
  required this.featuredImage,

});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'slug': slug,
      'categories': categories.join(','), // Comma-separated for backend
      'tags': tags.join(','), // Comma-separated for backend
      'content': content,
      'featuredImage': featuredImage, // Include if needed
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      categories: (map['categories'] as String).split(','),
      tags: (map['tags'] as String).split(','),
      content: map['content'] ?? '',
      featuredImage: map['featuredImage'] ?? '',
    );
  }


}
