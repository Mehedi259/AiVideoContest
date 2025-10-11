class ProfileModel {
  final int id;
  final String email;
  final String username;
  final String fullname;
  final String profilePicture;
  final List<UploadedVideoInfo> uploadedVideos;

  ProfileModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    required this.profilePicture,
    required this.uploadedVideos,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> videosJson = json['videos'] ?? []; //
    final List<UploadedVideoInfo> videos =
    videosJson.map((v) => UploadedVideoInfo.fromJson(v)).toList();

    return ProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      fullname: json['fullname'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      uploadedVideos: videos,
    );
  }
}

class UploadedVideoInfo {
  final int id;
  final String title;
  final String themeName;
  final VideoUserInfo? user;
  final String videoFile;
  final String thumbnail;
  final int views;

  UploadedVideoInfo({
    required this.id,
    required this.title,
    required this.themeName,
    this.user,
    required this.videoFile,
    required this.thumbnail,
    required this.views,
  });

  factory UploadedVideoInfo.fromJson(Map<String, dynamic> json) {
    return UploadedVideoInfo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      themeName: json['theme_name'] ?? '',
      user: json['user'] != null ? VideoUserInfo.fromJson(json['user']) : null,
      videoFile: json['video_file'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      views: json['views'] ?? 0,
    );
  }
}

class VideoUserInfo {
  final int id;
  final String username;

  VideoUserInfo({
    required this.id,
    required this.username,
  });

  factory VideoUserInfo.fromJson(Map<String, dynamic> json) {
    return VideoUserInfo(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
    );
  }
}

class VoteCountModel {
  final int userVoteCount;

  VoteCountModel({required this.userVoteCount});

  factory VoteCountModel.fromJson(Map<String, dynamic> json) {
    return VoteCountModel(
      userVoteCount: json['user_vote_count'] ?? 0,
    );
  }
}
