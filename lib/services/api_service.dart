import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = "http://127.0.0.1/gaming_store_api";

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/products.php"));

    print("RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List data = jsonData['data']; // ✅ FIXED

      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
