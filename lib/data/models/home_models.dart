class VideoModel {
  final int id;
  final String title;
  final String themeName;
  final UserModel user;
  final String videoFile;
  final String thumbnail;
  final int views;
  final String? themeCoverImageUrl;
  final int? vote;

  VideoModel({
    required this.id,
    required this.title,
    required this.themeName,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
    required this.views,
    this.themeCoverImageUrl,
    this.vote,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      views: json['views'] ?? 0,
      themeCoverImageUrl: json['theme_cover_image_url'],
      vote: json['vote'],
    );
  }
}

class UserModel {
  final int id;
  final String username;

  UserModel({
    required this.id,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}