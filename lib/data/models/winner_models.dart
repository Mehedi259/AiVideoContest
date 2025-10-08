class WinnerVideoModel {
  final int id;
  final String title;
  final String themeName;
  final WinnerUserInfo user;
  final String videoFile;
  final String thumbnail;

  WinnerVideoModel({
    required this.id,
    required this.title,
    required this.themeName,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
  });

  factory WinnerVideoModel.fromJson(Map<String, dynamic> json) {
    return WinnerVideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: WinnerUserInfo.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class WinnerUserInfo {
  final int id;
  final String username;

  WinnerUserInfo({
    required this.id,
    required this.username,
  });

  factory WinnerUserInfo.fromJson(Map<String, dynamic> json) {
    return WinnerUserInfo(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}