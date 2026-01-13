import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krib/data/providers/property_provider.dart';
import 'package:krib/data/repositories/favorites_repository.dart';
import 'package:krib/presentation/krib_list/widgets/krib_list_card.dart';

// Provides the list of ONLY the favorited Property objects
// This combines the stream of IDs from FavoritesRepo with the full list from PropertyProvider
final favoritePropertiesProvider = StreamProvider.autoDispose((ref) {
  final favoritesRepo = ref.watch(favoritesProvider);
  
  // We need to listen to the favorites stream
  // And map those IDs to actual properties from the Feed
  // Note: ideally we would fetch by ID from the repo, but for Mock/MVP we filter the feed.
  
  return favoritesRepo.watchFavorites().asyncMap((favoriteIds) async {
    final allProperties = await ref.read(rentCastServiceProvider).getProperties(city: 'Austin', state: 'TX'); // Fetch or use cached
    // Filter
    return allProperties.where((p) => favoriteIds.contains(p.id)).toList();
  });
});

class KribListScreen extends ConsumerWidget {
  const KribListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritePropertiesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Krib List', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: favoritesAsync.when(
        data: (properties) {
          if (properties.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 60, color: Colors.grey[800]),
                  const SizedBox(height: 16),
                  Text(
                    "Your Krib List is empty.",
                    style: GoogleFonts.outfit(color: Colors.white54, fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75, // Taller cards
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return KribListCard(property: properties[index]);
                    },
                    childCount: properties.length,
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.pinkAccent)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }
}
