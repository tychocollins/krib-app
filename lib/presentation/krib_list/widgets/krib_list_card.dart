import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/data/repositories/favorites_repository.dart';
import 'package:krib/domain/models/property_model.dart';
import 'package:krib/presentation/property_details/property_details_screen.dart';

class KribListCard extends ConsumerWidget {
  final Property property;

  const KribListCard({super.key, required this.property});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Determine status tag based on price or arbitrary logic for now
    String status = "Active";
    Color statusColor = Colors.greenAccent;

    if (property.price > 1000000) {
      status = "Price Drop";
      statusColor = Colors.orangeAccent;
    } else if (property.bedrooms > 4) {
      status = "New";
      statusColor = Colors.blueAccent;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
               builder: (context) => PropertyDetailsScreen(property: property),
            ),
          );
        },
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thumbnail Image
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'property_image_${property.id}',
                  child: Image.network(
                    property.imageUrls.first,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey[800]),
                  ),
                ),
                // Gradient
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ),
                // Status Tag
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withOpacity(0.5)),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.outfit(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                
                // Remove Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      ref.read(favoritesProvider).removeFavorite(property.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Removed ${property.address} from favorites"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                       color: Colors.black54,
                       shape: BoxShape.circle,
                       border: Border.all(color: Colors.white24),
                      ),
                      child: const Icon(Icons.favorite, color: Color(0xFFE91E63), size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${_formatPrice(property.price)}',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  property.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  '${property.city}, ${property.state}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '${(price / 1000).round()}k';
    }
    return price.toString();
  }
}
