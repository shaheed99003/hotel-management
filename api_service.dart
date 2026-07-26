import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8000/api";

  static Future<List<dynamic>> getHotels() async {
    final response =
        await http.get(Uri.parse("$baseUrl/hotel-details/"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load hotels");
  }

  static Future<void> createHotel(
      String name,
      String address,
      double price,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/hotel-details/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "address": address,
        "price": price,
      }),
    );

    print(response.statusCode);
    print(response.body);
  }

  static Future<void> updateHotel(
      int id,
      String name,
      String address,
      double price,
      ) async {

    await http.put(
      Uri.parse("$baseUrl/hotel-details/$id/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "address": address,
        "price": price,
      }),
    );
  }

  static Future<void> deleteHotel(int id) async {
    await http.delete(
      Uri.parse("$baseUrl/hotel-details/$id/"),
    );
  }
}