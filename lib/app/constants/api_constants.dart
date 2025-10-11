class ApiConstants {
  static const String baseUrl = "http://10.10.7.86:8000";

  // Auth Endpoints
  static const String register = "/api/user/register/";
  static const String verifyOtp = "/api/user/verify-otp/";
  static const String login = "/api/user/login/";
  static const String sendResetPasswordEmail = "/api/user/send-reset-password-email/";
  static const String resetPasswordOtp = "/api/user/reset-password-otp/";
  static const String setNewPassword = "/api/user/set-new-password/";

  // Dashboard Endpoints
  static const String videos = "/api/dashboard/videos/";
  static const String leaderboard = "/api/dashboard/leaderboard/";
  static const String likedVideos = "/api/dashboard/videos/liked/";
  static const String activeTheme = "/api/dashboard/active-theme/";
  static const String uploadVideo = "/api/dashboard/videos/upload/";
  static const String winner = "/api/dashboard/winner/";
  static const String votes = "/api/dashboard/votes/";
  static const String deleteAccount = "/api/dashboard/delete-account/";

  // User Profile
  static const String profile = "/api/user/profile/";
  static const String changePassword = "/api/user/change-password/";

  // Badges/Winners
  static const String winners = "/api/admin/winners/";

  // Video Actions
  static String videoAction(int videoId) => "/api/dashboard/videos/$videoId/action/";
  static String videoDetail(int videoId) => "/api/dashboard/videos/$videoId/";
  //static String deleteVideo(int videoId) => "/api/dashboard/videos/$videoId/delete/";
  static String downloadWinner(int winnerId) => "/api/winners/download/$winnerId/";
  static String deleteVideo(int id) => "/api/dashboard/videos/$id/delete/";
}