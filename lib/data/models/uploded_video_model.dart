class UploadedVideoModel {
  final int id;
  final String title;
  final String themeName;
  final UploadedVideoUser user;
  final String videoFile;
  final String thumbnail;
  final int views;

  UploadedVideoModel({
    required this.id,
    required this.title,
    required this.themeName,
    required this.user,
    required this.videoFile,
    required this.thumbnail,
    required this.views,
  });

  factory UploadedVideoModel.fromJson(Map<String, dynamic> json) {
    return UploadedVideoModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: UploadedVideoUser.fromJson(json['user'] ?? {}),
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      views: json['views'] ?? 0,
    );
  }
}

class UploadedVideoUser {
  final int id;
  final String username;

  UploadedVideoUser({
    required this.id,
    required this.username,
  });

  factory UploadedVideoUser.fromJson(Map<String, dynamic> json) {
    return UploadedVideoUser(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}

class UploadedVideosResponse {
  final List<UploadedVideoModel> uploadedVideos;

  UploadedVideosResponse({required this.uploadedVideos});

  factory UploadedVideosResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> videosJson = json['uploaded_videos'] ?? [];
    final List<UploadedVideoModel> videos = videosJson
        .map((v) => UploadedVideoModel.fromJson(v))
        .toList();

    return UploadedVideosResponse(uploadedVideos: videos);
  }
}