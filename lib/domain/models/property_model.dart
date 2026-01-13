class Property {
  final String id;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int squareFootage;
  final String propertyType;
  final List<String> imageUrls;
  final String? description;
  final double? latitude;
  final double? longitude;

  const Property({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.squareFootage,
    required this.propertyType,
    required this.imageUrls,
    this.description,
    this.latitude,
    this.longitude,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String? ?? '',
      address: json['address'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      bedrooms: json['bedrooms'] as int? ?? 0,
      bathrooms: json['bathrooms'] as int? ?? 0,
      squareFootage: json['squareFootage'] as int? ?? 0,
      propertyType: json['propertyType'] as String? ?? '',
      imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      description: json['description'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'squareFootage': squareFootage,
      'propertyType': propertyType,
      'imageUrls': imageUrls,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
