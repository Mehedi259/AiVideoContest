// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import '../../app/constants/api_constants.dart';
// import '../../app/utils/storage_helper.dart';
//
// class ApiService {
//   // ... (keep your existing GET, POST, PUT, DELETE methods)
//
//   /// =============================
//   /// FIXED: Multipart PUT request with proper error handling
//   /// =============================
//   static Future<dynamic> putMultipartRequest(
//       String endpoint, {
//         Map<String, String>? fields,
//         Map<String, File>? files,
//         Map<String, Uint8List>? webFiles,
//       }) async {
//     try {
//       final token = await StorageHelper.getToken();
//       final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");
//
//       var request = http.MultipartRequest('PUT', uri);
//
//       // Add authorization header
//       final cleaned = token?.trim() ?? "";
//       if (cleaned.isNotEmpty) {
//         request.headers['Authorization'] = 'Bearer $cleaned';
//       }
//
//       // Add text fields
//       if (fields != null) {
//         request.fields.addAll(fields);
//         print("📤 Fields being sent: $fields");
//       }
//
//       // Add files for Mobile platforms
//       if (!kIsWeb && files != null) {
//         for (var entry in files.entries) {
//           final file = await http.MultipartFile.fromPath(
//             entry.key,
//             entry.value.path,
//           );
//           request.files.add(file);
//           print("📱 Mobile file added: ${entry.key} -> ${entry.value.path}");
//         }
//       }
//
//       // Add files for Web platform
//       if (kIsWeb && webFiles != null) {
//         for (var entry in webFiles.entries) {
//           final file = http.MultipartFile.fromBytes(
//             entry.key,
//             entry.value,
//             filename: 'profile_image.jpg', // Provide a proper filename
//           );
//           request.files.add(file);
//           print("🌐 Web file added: ${entry.key} (${entry.value.length} bytes)");
//         }
//       }
//
//       print("🚀 Sending multipart request to: $uri");
//       print("📋 Request headers: ${request.headers}");
//       print("📂 Files count: ${request.files.length}");
//
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
//
//       print("📥 Response status: ${response.statusCode}");
//       print("📥 Response body: ${response.body}");
//
//       return _processResponse(response);
//     } catch (e) {
//       print("❌ Multipart PUT error: $e");
//       throw Exception("Multipart PUT request error: $e");
//     }
//   }
//
//   /// =============================
//   /// Headers with Token (JSON APIs only)
//   /// =============================
//   static Map<String, String> _headers(String? token) {
//     final cleaned = token?.trim() ?? "";
//     final headers = <String, String>{
//       "Content-Type": "application/json",
//     };
//
//     if (cleaned.isNotEmpty) {
//       headers["Authorization"] = "Bearer $cleaned";
//     }
//
//     return headers;
//   }
//
//   /// =============================
//   /// Response Handler
//   /// =============================
//   static dynamic _processResponse(http.Response response) {
//     final statusCode = response.statusCode;
//
//     if (statusCode >= 200 && statusCode < 305) {
//       if (response.body.isNotEmpty) {
//         try {
//           return jsonDecode(response.body);
//         } catch (e) {
//           print("⚠️ JSON decode error: $e");
//           return {"message": response.body};
//         }
//       } else {
//         return {};
//       }
//     } else {
//       print("❌ HTTP Error ${response.statusCode}: ${response.body}");
//       throw Exception("Error ${response.statusCode}: ${response.body}");
//     }
//   }
//
//   // Add other methods (GET, POST, DELETE) here if they're missing...
//   static Future<dynamic> getRequest(String endpoint,
//       {Map<String, String>? queryParams}) async {
//     try {
//       final token = await StorageHelper.getToken();
//       final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint")
//           .replace(queryParameters: queryParams);
//
//       final response = await http.get(
//         uri,
//         headers: _headers(token),
//       );
//
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("GET request error: $e");
//     }
//   }
//
//   static Future<dynamic> postRequest(String endpoint,
//       {Map<String, dynamic>? body}) async {
//     try {
//       final token = await StorageHelper.getToken();
//       final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");
//
//       final response = await http.post(
//         uri,
//         headers: _headers(token),
//         body: jsonEncode(body),
//       );
//
//       return _processResponse(response);
//     } catch (e) {
//       throw Exception("POST request error: $e");
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../app/utils/storage_helper.dart';
import '../../app/constants/api_constants.dart';

class ApiService {
  /// POST Request
  static Future<dynamic> postRequest(String endpoint,
      {Map<String, dynamic>? body}) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");

      developer.log('📤 POST Request to: $uri', name: 'ApiService');
      developer.log('📦 Body: $body', name: 'ApiService');

      final response = await http.post(
        uri,
        headers: _headers(token),
        body: jsonEncode(body),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ApiService');
      developer.log('📥 Response Body: ${response.body}', name: 'ApiService');

      return _processResponse(response);
    } catch (e) {
      developer.log('❌ POST Error: $e', name: 'ApiService');
      throw Exception("POST request error: $e");
    }
  }

  /// GET Request
  static Future<dynamic> getRequest(String endpoint,
      {Map<String, String>? queryParams}) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint")
          .replace(queryParameters: queryParams);

      developer.log('📤 GET Request to: $uri', name: 'ApiService');

      final response = await http.get(
        uri,
        headers: _headers(token),
      );

      developer.log('📥 Response Status: ${response.statusCode}', name: 'ApiService');
      developer.log('📥 Response Body: ${response.body}', name: 'ApiService');

      return _processResponse(response);
    } catch (e) {
      developer.log('❌ GET Error: $e', name: 'ApiService');
      throw Exception("GET request error: $e");
    }
  }

  /// Multipart PUT request
  static Future<dynamic> putMultipartRequest(
      String endpoint, {
        Map<String, String>? fields,
        Map<String, File>? files,
        Map<String, Uint8List>? webFiles,
      }) async {
    try {
      final token = await StorageHelper.getToken();
      final uri = Uri.parse("${ApiConstants.baseUrl}$endpoint");

      var request = http.MultipartRequest('PUT', uri);

      final cleaned = token?.trim() ?? "";
      if (cleaned.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $cleaned';
      }

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (!kIsWeb && files != null) {
        for (var entry in files.entries) {
          final file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value.path,
          );
          request.files.add(file);
        }
      }

      if (kIsWeb && webFiles != null) {
        for (var entry in webFiles.entries) {
          final file = http.MultipartFile.fromBytes(
            entry.key,
            entry.value,
            filename: 'profile_image.jpg',
          );
          request.files.add(file);
        }
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      return _processResponse(response);
    } catch (e) {
      developer.log('❌ Multipart PUT Error: $e', name: 'ApiService');
      throw Exception("Multipart PUT request error: $e");
    }
  }

  /// Headers with Token
  static Map<String, String> _headers(String? token) {
    final cleaned = token?.trim() ?? "";
    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    if (cleaned.isNotEmpty) {
      headers["Authorization"] = "Bearer $cleaned";
    }

    return headers;
  }

  /// Response Handler
  static dynamic _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 305) {
      if (response.body.isNotEmpty) {
        try {
          return jsonDecode(response.body);
        } catch (e) {
          developer.log('⚠️ JSON decode error: $e', name: 'ApiService');
          return {"message": response.body};
        }
      } else {
        return {};
      }
    } else {
      developer.log('❌ HTTP Error ${response.statusCode}: ${response.body}', name: 'ApiService');
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}