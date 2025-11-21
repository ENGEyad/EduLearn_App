import 'dart:convert';
import 'package:http/http.dart' as http;

/// عدّل هذا الرابط حسب السيرفر.
/// في التطوير المحلي مع محاكي أندرويد:
/// http://10.0.2.2:8000/api
const String baseUrl = 'http://192.168.1.105:8000/api'; // استبدل الـ IP بواقع جهازك

class ApiService {
  /// تسجيل/دخول الطالب باستخدام:
  /// full_name + academic_id (+ email/password اختياري)
  static Future<Map<String, dynamic>> authStudent({
    required String fullName,
    required String academicId,
    String? email,
    String? password,
  }) async {
    final url = Uri.parse('$baseUrl/student/auth');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'full_name': fullName,
        'academic_id': academicId,
        if (email != null && email.isNotEmpty) 'email': email,
        if (password != null && password.isNotEmpty) 'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Auth failed');
    }
  }

  /// تسجيل/دخول الأستاذ باستخدام:
  /// full_name + teacher_code (+ email/password اختياري)
  static Future<Map<String, dynamic>> authTeacher({
    required String fullName,
    required String teacherCode,
    String? email,
    String? password,
  }) async {
    final url = Uri.parse('$baseUrl/teacher/auth');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'full_name': fullName,
        'teacher_code': teacherCode,
        if (email != null && email.isNotEmpty) 'email': email,
        if (password != null && password.isNotEmpty) 'password': password,
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Auth failed');
    }
  }
}
