//lib/app/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = "https://prommt.cc";

  // Auth Endpoints
  static const String register = "/api/user/register/";
  static const String verifyOtp = "/api/user/verify-otp/";
  static const String login = "/api/user/login/";
  static const String sendResetPasswordEmail = "/api/user/send-reset-password-email/";
  static const String resetPasswordOtp = "/api/user/reset-password-otp/";
  static const String setNewPassword = "/api/user/set-new-password/";

  // Social Login Endpoints
  static const String googleLogin = "/api/user/google/id-token/";
  static const String appleLogin = "/api/dj-rest-auth/apple/";

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

  // Badges/Winners - FIXED: Changed from /api/admin/winners/ to /api/winners/
  static const String winners = "/api/winners/";

  // NEW: Competition & Feedback
  static const String themes = "/api/dashboard/themes/";
  static const String feedback = "/api/dashboard/feedback/";

  // Video Actions
  static String videoAction(int videoId) => "/api/dashboard/videos/$videoId/action/";
  static String videoDetail(int videoId) => "/api/dashboard/videos/$videoId/";
  static String downloadWinner(int winnerId) => "/api/winners/download/$winnerId/";
  static String deleteVideo(int id) => "/api/dashboard/videos/$id/delete/";
}