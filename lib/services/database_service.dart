import 'dart:convert';
import 'package:http/http.dart' as http;

class DatabaseService {
  static const String _base = 'http://127.0.0.1/gaming_store_api';
  // change if using real phone

  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/users.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'signup',
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/users.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'login',
          'username': username,
          'password': password,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateProfile({
    required int userId,
    required String name,
    required String phone,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/users.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'update_profile',
          'user_id': userId,
          'name': name,
          'phone': phone,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateEmail({
    required int userId,
    required String newEmail,
    required String currentPassword,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/users.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'update_email',
          'user_id': userId,
          'new_email': newEmail,
          'current_password': currentPassword,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/users.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'change_password',
          'user_id': userId,
          'current_password': currentPassword,
          'new_password': newPassword,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> getProducts({
    String category = '',
  }) async {
    try {
      final url = category.isEmpty
          ? '$_base/products.php'
          : '$_base/products.php?category=$category';

      final res = await http.get(Uri.parse(url));
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> placeOrder({
    required int userId,
    required List<Map<String, dynamic>> items,
    required double total,
    String? note,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/orders.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'place_order',
          'user_id': userId,
          'total_price': total,
          'note': note ?? '',
          'items': items,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> getOrders(int userId) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/orders.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'action': 'get_orders', 'user_id': userId}),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/orders.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'update_status',
          'order_id': orderId,
          'status': status,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  static Future<Map<String, dynamic>> cancelOrder({
    required int orderId,
    required int userId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/orders.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'action': 'cancel_order',
          'order_id': orderId,
          'user_id': userId,
        }),
      );
      return jsonDecode(res.body);
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}
