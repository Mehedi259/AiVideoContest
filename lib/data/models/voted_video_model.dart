class VotedVideoModel {
  final int id;
  final VotedVideoDetail video;

  VotedVideoModel({
    required this.id,
    required this.video,
  });

  factory VotedVideoModel.fromJson(Map<String, dynamic> json) {
    return VotedVideoModel(
      id: json['id'] ?? 0,
      video: VotedVideoDetail.fromJson(json['video'] ?? {}),
    );
  }
}

class VotedVideoDetail {
  final int id;
  final String title;
  final String themeName;
  final VotedUserInfo user;
  final String videoFile;
  final String thumbnail;
  final int views;

  VotedVideoDetail({
    required this.id,
    required this.title,
    required this.themeName,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
    required this.views,
  });

  factory VotedVideoDetail.fromJson(Map<String, dynamic> json) {
    return VotedVideoDetail(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: VotedUserInfo.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      views: json['views'] ?? 0,
    );
  }
}

class VotedUserInfo {
  final int id;
  final String username;

  VotedUserInfo({
    required this.id,
    required this.username,
  });

  factory VotedUserInfo.fromJson(Map<String, dynamic> json) {
    return VotedUserInfo(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}