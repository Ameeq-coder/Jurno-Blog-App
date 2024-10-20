class DeleteBlogCategoryModel {
  final String blogCategory;

  DeleteBlogCategoryModel({
    required this.blogCategory,
  });

  factory DeleteBlogCategoryModel.fromJson(Map<String, dynamic> json) {
    return DeleteBlogCategoryModel(
      blogCategory: json['blogcategory'],
    );
  }

  // Convert DeleteBlogCategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'blogcategory': blogCategory,
    };
  }
}
