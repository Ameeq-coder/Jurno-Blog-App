class UpdateBlogCategoryModel {
  final String oldBlogCategory;
  final String newBlogCategory;
  final String newSlug;

  UpdateBlogCategoryModel({
    required this.oldBlogCategory,
    required this.newBlogCategory,
    required this.newSlug,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldBlogCategory': oldBlogCategory,
      'newBlogCategory': newBlogCategory,
      'newSlug': newSlug,
    };
  }
}
