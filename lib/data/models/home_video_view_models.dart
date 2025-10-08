class VideoDetailModel {
  final int id;
  final String title;
  final UserModel user;
  final String videoFile;

  VideoDetailModel({
    required this.id,
    required this.title,
    required this.user,
    required this.videoFile,
  });

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) {
    return VideoDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
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