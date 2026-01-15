import 'package:http/http.dart' as http;
import 'package:krib/data/services/rentcast_service.dart';
import 'package:krib/domain/models/property_model.dart';
import 'dart:math';

class MockRentCastService implements RentCastService {
  MockRentCastService(http.Client client, {required String apiKey});

  @override
  @override
  Future<List<Property>> getProperties({
    required String city,
    required String state,
    int limit = 20,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Expanded Mock Database
    final allProperties = [
      // Austin, TX
      const Property(
        id: 'mock_austin_1',
        address: '123 Austin Blvd',
        city: 'Austin',
        state: 'TX',
        zipCode: '78701',
        price: 450000,
        bedrooms: 3,
        bathrooms: 2,
        squareFootage: 1800,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Modern downtown living with spacious interiors.',
      ),
      const Property(
        id: 'mock_austin_2',
        address: '456 Congress Ave',
        city: 'Austin',
        state: 'TX',
        zipCode: '78704',
        price: 650000,
        bedrooms: 4,
        bathrooms: 3,
        squareFootage: 2400,
        propertyType: 'Condo',
        imageUrls: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Luxury high-rise condo with panoramic city views.',
      ),
      const Property(
        id: 'mock_austin_3',
        address: '789 Lake Travis Dr',
        city: 'Austin',
        state: 'TX',
        zipCode: '78734',
        price: 950000,
        bedrooms: 5,
        bathrooms: 4,
        squareFootage: 3500,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1600596542815-22b5c010deb7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Waterfront property with private dock access.',
      ),
       const Property(
        id: 'mock_austin_4',
        address: '321 Zilker Park Way',
        city: 'Austin',
        state: 'TX',
        zipCode: '78746',
        price: 1200000,
        bedrooms: 4,
        bathrooms: 4,
        squareFootage: 3200,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Architectural masterpiece near Zilker Park.',
      ),

      // New York, NY
      const Property(
        id: 'mock_ny_1',
        address: '101 Park Ave',
        city: 'New York',
        state: 'NY',
        zipCode: '10172',
        price: 2500000,
        bedrooms: 2,
        bathrooms: 2,
        squareFootage: 1200,
        propertyType: 'Condo',
        imageUrls: ['https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Exquisite Park Avenue condo with skyline views.',
      ),
      const Property(
        id: 'mock_ny_2',
        address: '55 Brooklyn Heights',
        city: 'Brooklyn', // Handling "New York" area fuzziness
        state: 'NY',
        zipCode: '11201',
        price: 1800000,
        bedrooms: 3,
        bathrooms: 2,
        squareFootage: 1800,
        propertyType: 'Brownstone',
        imageUrls: ['https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Classic Brownstone with modern renovations.',
      ),
      const Property(
        id: 'mock_ny_3',
        address: '88 SoHo Loft',
        city: 'New York',
        state: 'NY',
        zipCode: '10012',
        price: 3200000,
        bedrooms: 1,
        bathrooms: 1,
        squareFootage: 2000,
        propertyType: 'Loft',
        imageUrls: ['https://images.unsplash.com/photo-1502005229762-cf1c2da5c5d1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Expansive artist loft in the heart of SoHo.',
      ),

      // Los Angeles, CA
      const Property(
        id: 'mock_la_1',
        address: '123 Hollywood Hills',
        city: 'Los Angeles',
        state: 'CA',
        zipCode: '90068',
        price: 4500000,
        bedrooms: 4,
        bathrooms: 5,
        squareFootage: 4000,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Modern masterpiece with pool and canyon views.',
      ),
      const Property(
        id: 'mock_la_2',
        address: '456 Venice Blvd',
        city: 'Los Angeles',
        state: 'CA',
        zipCode: '90291',
        price: 2100000,
        bedrooms: 3,
        bathrooms: 2,
        squareFootage: 1800,
        propertyType: 'Bungalow',
        imageUrls: ['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Charming beach bungalow steps from the sand.',
      ),
       const Property(
        id: 'mock_la_3',
        address: '789 Beverly Dr',
        city: 'Los Angeles',
        state: 'CA',
        zipCode: '90210',
        price: 8500000,
        bedrooms: 6,
        bathrooms: 7,
        squareFootage: 7000,
        propertyType: 'Mansion',
        imageUrls: ['https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Iconic Beverly Hills estate with guest house.',
      ),
      
      // Miami, FL
       const Property(
        id: 'mock_miami_1',
        address: '10 Ocean Dr',
        city: 'Miami Beach',
        state: 'FL',
        zipCode: '33139',
        price: 1500000,
        bedrooms: 2,
        bathrooms: 2,
        squareFootage: 1400,
        propertyType: 'Condo',
        imageUrls: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Oceanfront Art Deco condo.',
      ),
    ];

    // Filter Logic
    final filtered = allProperties.where((property) {
      final cityMatch = property.city.toLowerCase() == city.toLowerCase();
      
      // Simple state matching - assuming strict 2-letter code for now
      final stateMatch = property.state.toLowerCase() == state.toLowerCase();
      
      // If filtering by just city (common mock behavior for ease), or both
      return cityMatch && stateMatch;
    }).toList();

    return filtered;
  }
}
