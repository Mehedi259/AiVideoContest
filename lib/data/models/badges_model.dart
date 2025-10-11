class BadgeModel {
  final int id;
  final String message;
  final String picture;
  final String download;
  final int totalVotes;
  final String username;

  BadgeModel({
    required this.id,
    required this.message,
    required this.picture,
    required this.download,
    required this.totalVotes,
    required this.username,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'] ?? 0,
      message: json['message'] ?? '',
      picture: json['picture'] ?? '',
      download: json['download'] ?? '',
      totalVotes: json['total_votes'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}