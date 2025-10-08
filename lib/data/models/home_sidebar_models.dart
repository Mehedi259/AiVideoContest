class ProfileModel {
  final int id;
  final String email;
  final String username;
  final String fullname;
  final String profilePicture;
  final bool isAdmin;
  final String? download;
  final String createdAt;

  ProfileModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    required this.profilePicture,
    required this.isAdmin,
    this.download,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      fullname: json['fullname'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      isAdmin: json['is_admin'] ?? false,
      download: json['download'],
      createdAt: json['created_at'] ?? '',
    );
  }

  String get fullProfilePictureUrl {
    if (profilePicture.startsWith('http')) {
      return profilePicture;
    }
    return 'http://10.10.7.86:8000$profilePicture';
  }
}