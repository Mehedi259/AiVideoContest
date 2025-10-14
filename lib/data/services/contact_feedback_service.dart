import 'dart:developer' as developer;
import '../../app/constants/api_constants.dart';
import './api_service.dart';

class ContactFeedbackService {
  /// Submit feedback
  static Future<Map<String, dynamic>> submitFeedback(String feedbackText) async {
    try {
      developer.log('📤 Submitting feedback...', name: 'ContactFeedbackService');

      final body = {
        "feedback_text": feedbackText,
      };

      final response = await ApiService.postRequest(
        ApiConstants.feedback,
        body: body,
      );

      developer.log('✅ Feedback submitted successfully', name: 'ContactFeedbackService');
      return response;
    } catch (e) {
      developer.log('❌ Error submitting feedback: $e', name: 'ContactFeedbackService');
      rethrow;
    }
  }
}