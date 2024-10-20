class BlogCategoryModel{

  final String blogcategory;
  final String slug;

  BlogCategoryModel({required this.blogcategory, required this.slug});

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) {
    return BlogCategoryModel(
      blogcategory: json['blogcategory'],
      slug: json['slug'],
    );
  }

}