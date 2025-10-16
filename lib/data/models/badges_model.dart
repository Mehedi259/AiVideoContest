class BadgeModel {
  final int id;
  final String username;
  final String message;
  final String picture;
  final String download;
  final int totalVotes;

  BadgeModel({
    required this.id,
    required this.username,
    required this.message,
    required this.picture,
    required this.download,
    required this.totalVotes,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      message: json['message'] ?? '',
      picture: json['picture'] ?? '',
      download: json['download'] ?? '',
      totalVotes: json['total_votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'message': message,
      'picture': picture,
      'download': download,
      'total_votes': totalVotes,
    };
  }
}