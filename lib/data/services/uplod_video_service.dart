import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../app/constants/api_constants.dart';
import '../../app/utils/storage_helper.dart';
import '../models/uplod_video_models.dart';
import 'api_service.dart';

class UploadVideoService {
  /// 🔹 Fetch Active Theme from API
  static Future<Map<String, dynamic>> fetchActiveTheme() async {
    try {
      final response = await ApiService.getRequest(ApiConstants.activeTheme);

      developer.log('📦 Active Theme Response: $response', name: 'UploadVideoService');

      final theme = ActiveThemeModel.fromJson(response);
      return {
        'success': true,
        'theme': theme,
      };
    } catch (e) {
      developer.log('❌ Fetch Active Theme Error: $e', name: 'UploadVideoService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }

  /// 🔹 Upload Video with Thumbnail, Title & Theme
  static Future<Map<String, dynamic>> uploadVideo({
    required String title,
    required String themeName,
    required File? videoFile,
    required File? thumbnailFile,
    required Uint8List? webVideoBytes,
    required Uint8List? webThumbnailBytes,
  }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.uploadVideo}");

      var request = http.MultipartRequest('POST', uri);

      // ✅ Authorization Header
      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      // ✅ Add Fields
      request.fields['title'] = title;
      request.fields['theme_name'] = themeName;

      // ✅ Add Video (Web or Mobile)
      if (!kIsWeb && videoFile != null) {
        final video = await http.MultipartFile.fromPath(
          'video_file',
          videoFile.path,
        );
        request.files.add(video);
      } else if (kIsWeb && webVideoBytes != null) {
        final video = http.MultipartFile.fromBytes(
          'video_file',
          webVideoBytes,
          filename: 'video.mp4',
        );
        request.files.add(video);
      }

      // ✅ Add Thumbnail (Web or Mobile)
      if (!kIsWeb && thumbnailFile != null) {
        final thumb = await http.MultipartFile.fromPath(
          'thumbnail',
          thumbnailFile.path,
        );
        request.files.add(thumb);
      } else if (kIsWeb && webThumbnailBytes != null) {
        final thumb = http.MultipartFile.fromBytes(
          'thumbnail',
          webThumbnailBytes,
          filename: 'thumbnail.jpg',
        );
        request.files.add(thumb);
      }

      developer.log('📤 Uploading video...', name: 'UploadVideoService');

      // ✅ Send Request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log('📥 Upload Response Status: ${response.statusCode}', name: 'UploadVideoService');
      developer.log('📥 Upload Response Body: ${response.body}', name: 'UploadVideoService');

      // ✅ Handle Response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        final uploadedVideo = UploadedVideoModel.fromJson(data);

        return {
          'success': true,
          'message': 'Video uploaded successfully',
          'video': uploadedVideo,
        };
      } else {
        throw Exception("Upload failed: ${response.body}");
      }
    } catch (e) {
      developer.log('❌ Upload Video Error: $e', name: 'UploadVideoService');
      return {
        'success': false,
        'message': e.toString().replaceAll('Exception: ', ''),
      };
    }
  }
}
