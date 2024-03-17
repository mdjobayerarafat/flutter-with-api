class Panda {
  final int id;
  final String title;
  final String description;
  final int rating;
  final String trailer;
  final String download;
  final bool complete;

  Panda({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.trailer,
    required this.download,
    required this.complete,
  });

  factory Panda.fromJson(Map<String, dynamic> json) {
    return Panda(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      rating: json['rating'],
      trailer: json['trailer'],
      download: json['download'],
      complete: json['complete'],
    );
  }
}