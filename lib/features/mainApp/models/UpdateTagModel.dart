class UpdateTagModel{

  final String oldTag;
  final String newTag;
  final String newSlug;

  UpdateTagModel({
    required this.oldTag,
    required this.newTag,
    required this.newSlug,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldTag': oldTag,
      'newTag': newTag,
      'newSlug': newSlug,
    };
  }


}