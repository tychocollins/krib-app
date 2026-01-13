import 'package:flutter/material.dart';
import 'package:krib/domain/models/property_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/presentation/property_details/property_details_screen.dart';

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {
          print('DEBUG: PropertyCard tapped. Navigating to details.');
          // Use a callback or direct navigation if we have context. 
          // Since we are inside the widget, we can use Navigator.
           Navigator.push(
            context,
            MaterialPageRoute(
               builder: (context) => PropertyDetailsScreen(property: property),
            ),
          );
        },
        child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Hero(
            tag: 'property_image_${property.id}',
            child: Image.network(
              property.imageUrls.first,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey[800], child: const Center(child: Icon(Icons.error)));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[900],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Gradient Overlay
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
                stops: [0.6, 1.0],
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${property.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  property.address,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                 Text(
                  '${property.city}, ${property.state}',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _FeatureChip(icon: Icons.bed, label: '${property.bedrooms} Beds'),
                    const SizedBox(width: 8),
                    _FeatureChip(icon: Icons.bathtub, label: '${property.bathrooms} Baths'),
                    const SizedBox(width: 8),
                    _FeatureChip(icon: Icons.square_foot, label: '${property.squareFootage} sqft'),
                  ],
                ),
                const SizedBox(height: 20), // Bottom padding for navigation bar if needed
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: GoogleFonts.outfit(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}
