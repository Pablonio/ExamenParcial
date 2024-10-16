class Publication {
  final int? id;
  final String title;
  final String content;
  final int likes;
  final String? imagePath;
  final int userId;

  Publication({
    this.id,
    required this.title,
    required this.content,
    this.likes = 0,
    this.imagePath,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'likes': likes,
      'imagePath': imagePath,
      'userId': userId,
    };
  }
}
