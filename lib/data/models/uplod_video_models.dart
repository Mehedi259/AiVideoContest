class ActiveThemeModel {
  final String themeName;

  ActiveThemeModel({required this.themeName});

  factory ActiveThemeModel.fromJson(Map<String, dynamic> json) {
    return ActiveThemeModel(
      themeName: json['theme_name'] ?? '',
    );
  }
}

class UploadedVideoModel {
  final int id;
  final String title;
  final String themeName;
  final UploadUserInfo user;
  final String videoFile;
  final String thumbnail;

  UploadedVideoModel({
    required this.id,
    required this.title,
    required this.themeName,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
  });

  factory UploadedVideoModel.fromJson(Map<String, dynamic> json) {
    return UploadedVideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: UploadUserInfo.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }
}

class UploadUserInfo {
  final int id;
  final String username;

  UploadUserInfo({
    required this.id,
    required this.username,
  });

  factory UploadUserInfo.fromJson(Map<String, dynamic> json) {
    return UploadUserInfo(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}