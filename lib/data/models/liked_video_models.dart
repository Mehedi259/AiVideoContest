class LikedVideoModel {
  final VideoInfo video;

  LikedVideoModel({required this.video});

  factory LikedVideoModel.fromJson(Map<String, dynamic> json) {
    return LikedVideoModel(
      video: VideoInfo.fromJson(json['video'] ?? {}),
    );
  }
}

class VideoInfo {
  final int id;
  final String title;
  final UserInfo user;
  final String videoFile;
  final String thumbnail;

  VideoInfo({
    required this.id,
    required this.title,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
  });

  factory VideoInfo.fromJson(Map<String, dynamic> json) {
    return VideoInfo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      user: UserInfo.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class UserInfo {
  final int id;
  final String username;

  UserInfo({
    required this.id,
    required this.username,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}