class TagModel {
  final String tag;
  final String slug;

  TagModel({required this.tag, required this.slug});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(tag: json['tag'], slug: json['slug']);
  }
}
