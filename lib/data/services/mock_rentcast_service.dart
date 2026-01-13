import 'package:http/http.dart' as http;
import 'package:krib/data/services/rentcast_service.dart';
import 'package:krib/domain/models/property_model.dart';
import 'dart:math';

class MockRentCastService implements RentCastService {
  MockRentCastService(http.Client client, {required String apiKey});

  @override
  Future<List<Property>> getProperties({
    required String city,
    required String state,
    int limit = 20,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Helper to generate random properties for infinite-feeling scroll
    final random = Random();
    
    final List<Property> hardcoded = [
      const Property(
        id: 'mock_1',
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
        id: 'mock_2',
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
        id: 'mock_3',
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
        id: 'mock_4',
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
      const Property(
        id: 'mock_5',
        address: '555 Rainey St',
        city: 'Austin',
        state: 'TX',
        zipCode: '78701',
        price: 525000,
        bedrooms: 2,
        bathrooms: 2,
        squareFootage: 1100,
        propertyType: 'Apartment',
        imageUrls: ['https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Trendy apartment in the heart of the entertainment district.',
      ),
      const Property(
        id: 'mock_6',
        address: '888 Hill Country Rd',
        city: 'Austin',
        state: 'TX',
        zipCode: '78736',
        price: 750000,
        bedrooms: 3,
        bathrooms: 3,
        squareFootage: 2600,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1580587771525-78b9dba3b91d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Quiet retreat surrounded by nature.',
      ),
      const Property(
        id: 'mock_7',
        address: '222 SoCo Blvd',
        city: 'Austin',
        state: 'TX',
        zipCode: '78704',
        price: 890000,
        bedrooms: 3,
        bathrooms: 2,
        squareFootage: 1950,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1583608205776-bfd35f0d9f8e?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Renovated bungalow on South Congress.',
      ),
      const Property(
        id: 'mock_8',
        address: '101 East Side Dr',
        city: 'Austin',
        state: 'TX',
        zipCode: '78702',
        price: 420000,
        bedrooms: 2,
        bathrooms: 1,
        squareFootage: 950,
        propertyType: 'Tiny Home',
        imageUrls: ['https://images.unsplash.com/photo-1518780664697-55e3ad937233?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Cozy and modern living on the East Side.',
      ),
      const Property(
        id: 'mock_9',
        address: '777 Domain Pkwy',
        city: 'Austin',
        state: 'TX',
        zipCode: '78758',
        price: 580000,
        bedrooms: 2,
        bathrooms: 2,
        squareFootage: 1300,
        propertyType: 'Condo',
        imageUrls: ['https://images.unsplash.com/photo-1484154218962-a1c002085d2f?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Steps away from shopping and dining at The Domain.',
      ),
      const Property(
        id: 'mock_10',
        address: '999 Tarrytown Ln',
        city: 'Austin',
        state: 'TX',
        zipCode: '78703',
        price: 1500000,
        bedrooms: 5,
        bathrooms: 4,
        squareFootage: 3800,
        propertyType: 'Single Family',
        imageUrls: ['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'],
        description: 'Classic elegance in the prestigious Tarrytown neighborhood.',
      ),
    ];

    return hardcoded;
  }
}
