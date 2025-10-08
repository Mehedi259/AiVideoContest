import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import '../models/home_sidebar_models.dart';
import 'api_service.dart';

class HomeSidebarService {
  /// Fetch user profile
  static Future<Map<String, dynamic>> fetchProfile() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.profile);
      developer.log('📦 Profile Response: $response', name: 'HomeSidebarService');

      final profile = ProfileModel.fromJson(response);
      return {
        'success': true,
        'profile': profile,
      };
    } catch (e) {
      developer.log('❌ Fetch Profile Error: $e', name: 'HomeSidebarService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// Logout user
  static Future<void> logout() async {
    await StorageHelper.clearToken();
    developer.log('✅ User logged out', name: 'HomeSidebarService');
  }
}