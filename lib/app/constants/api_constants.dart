class ApiConstants {
  static const String baseUrl = "http://10.10.7.86:8000";

  // Auth Endpoints
  static const String register = "/api/user/register/";
  static const String verifyOtp = "/api/user/verify-otp/";
  static const String login = "/api/user/login/";
  static const String sendResetPasswordEmail = "/api/user/send-reset-password-email/";
  static const String resetPasswordOtp = "/api/user/reset-password-otp/";
  static const String setNewPassword = "/api/user/set-new-password/";
}