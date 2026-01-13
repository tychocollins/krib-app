import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/data/repositories/favorites_repository.dart';
import 'package:krib/domain/models/property_model.dart';
import 'package:intl/intl.dart';

class PropertyDetailsScreen extends ConsumerWidget {
  final Property property;

  const PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesRepo = ref.watch(favoritesProvider);
    final favoritesAsync = ref.watch(StreamProvider.autoDispose((ref) => favoritesRepo.watchFavorites()));

    final isFavorited = favoritesAsync.maybeWhen(
      data: (ids) => ids.contains(property.id),
      orElse: () => false,
    );

    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Hero Image Header
          SliverAppBar(
            expandedHeight: 400.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                   Hero(
                    tag: 'property_image_${property.id}',
                    child: Image.network(
                      property.imageUrls.isNotEmpty ? property.imageUrls.first : '',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(color: Colors.grey[900]),
                    ),
                  ),
                  // Gradient Overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black45,
                shape: const CircleBorder(),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Address
                  Text(
                    formatCurrency.format(property.price),
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
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    '${property.city}, ${property.state} ${property.zipCode}',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 24),

                  // Specs Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSpecItem(Icons.bed, '${property.bedrooms}', 'Beds'),
                      _buildVerticalDivider(),
                      _buildSpecItem(Icons.bathtub_outlined, '${property.bathrooms}', 'Baths'),
                      _buildVerticalDivider(),
                      _buildSpecItem(Icons.square_foot, '${property.squareFootage}', 'Sqft'),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    "Overview",
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    property.description ?? "No description available for this property.",
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.white70,
                    ),
                  ),
                  
                  // Bottom Spacing needed for FAB
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Floating Action Button for Favorite Toggle
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (isFavorited) {
            favoritesRepo.removeFavorite(property.id);
            // Optional: Show snackbar
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text("Removed from Krib List"), duration: Duration(seconds: 1)),
             );
          } else {
            favoritesRepo.addFavorite(property.id);
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(content: Text("Added to Krib List"),  duration: Duration(seconds: 1)),
             );
          }
        },
        backgroundColor: Colors.white,
        foregroundColor: isFavorited ? const Color(0xFFE91E63) : Colors.black, // Pink if liked
        icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
        label: Text(
          isFavorited ? "Saved" : "Save Property",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white24,
    );
  }
}
