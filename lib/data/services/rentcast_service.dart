import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:krib/domain/models/property_model.dart';

class RentCastService {
  final http.Client _client;
  final String _apiKey;
  final String _baseUrl = 'https://api.rentcast.io/v1';

  RentCastService(this._client, {required String apiKey}) : _apiKey = apiKey;

  Future<List<Property>> getProperties({
    required String city,
    required String state,
    int limit = 20,
  }) async {
    final uri = Uri.parse(
        '$_baseUrl/listings/sale?city=$city&state=$state&limit=$limit');

    final response = await _client.get(
      uri,
      headers: {
        'X-Api-Key': _apiKey,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // RentCast returns a slightly different structure, we'll map it to our model.
      // Note: This is a simplification. Real implementation might need more parsing logic.
      return data.map((json) => _mapToProperty(json)).toList();
    } else {
      throw Exception('Failed to load properties: ${response.statusCode}');
    }
  }

  Property _mapToProperty(Map<String, dynamic> json) {
    // Handling potential nulls or different field names
    return Property(
      id: json['id'] ?? '',
      address: json['addressLine1'] ?? 'Unknown Address',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      price: json['price'] ?? 0,
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      squareFootage: json['squareFootage'] ?? 0,
      propertyType: json['propertyType'] ?? 'Unknown',
      imageUrls: json['images'] != null 
          ? List<String>.from(json['images']) 
          : ['https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
