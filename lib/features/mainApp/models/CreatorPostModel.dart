class CreatorModelPost {
  final String id;
  final String image;
  final String title;
  final DateTime date;
  final int views;

  CreatorModelPost({
    required this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.views,
  });

  factory CreatorModelPost.fromJson(Map<String, dynamic> json) {
    return CreatorModelPost(
      id: json['_id'],
      image: json['featuredImage'],
      title: json['title'],
      date: DateTime.parse(json['createdAt']),
      views: json['views'],
    );
  }
}
