class PostPanda {
  final String title;
  final String description;
  final int rating;
  final String trailer;
  final String download;
  final bool complete;

  PostPanda({
    required this.title,
    required this.description,
    required this.rating,
    required this.trailer,
    required this.download,
    required this.complete,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'rating': rating,
      'trailer': trailer,
      'download': download,
      'complete': complete,
    };
  }
}