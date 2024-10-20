class DeleteTagModel{

  final String tag;
  final String slug;
  final String id;


  DeleteTagModel({
    required this.tag,
    required this.slug,
    required this.id,
  });
  factory DeleteTagModel.fromJson(Map<String, dynamic> json) {
    return DeleteTagModel(
      tag: json['tag'],
      slug: json['slug'],
      id: json['_id'],
    );
  }

  // Convert TagModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'slug': slug,
      '_id': id,
    };
  }



}