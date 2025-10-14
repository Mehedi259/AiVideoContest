import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../data/services/contact_feedback_service.dart';

class ContactFeedbackController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get successMessage => _successMessage;

  /// Submit feedback
  Future<bool> submitFeedback(String feedbackText) async {
    if (feedbackText.trim().isEmpty) {
      _error = 'Please enter your feedback';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await ContactFeedbackService.submitFeedback(feedbackText);

      _successMessage = 'Feedback submitted successfully!';
      developer.log('✅ Feedback submitted: ${response['feedback_text']}',
          name: 'ContactFeedbackController');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to submit feedback. Please try again.';
      developer.log('❌ Error: $e', name: 'ContactFeedbackController');

      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Clear messages
  void clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }
}