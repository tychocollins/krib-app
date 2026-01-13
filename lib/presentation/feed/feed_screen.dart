import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krib/data/providers/property_provider.dart';
import 'package:krib/data/repositories/favorites_repository.dart';
import 'package:krib/presentation/feed/widgets/property_card.dart';
import 'package:krib/presentation/krib_list/krib_list_screen.dart';
import 'package:krib/presentation/profile/profile_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propertiesAsync = ref.watch(propertyFeedProvider);
    final favoritesRepo = ref.read(favoritesProvider);

    return Scaffold(
      backgroundColor: Colors.black, // Ensure dark background for premium feel
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    },
                  ),
                   // Gradient Text or Logo
                  const Text(
                        "KRIB",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          letterSpacing: 1.2,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KribListScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            
            // Swiper
            Expanded(
              child: propertiesAsync.when(
                data: (properties) {
                  if (properties.isEmpty) {
                    return const Center(child: Text("No properties found.", style: TextStyle(color: Colors.white)));
                  }
                  return CardSwiper(
                    controller: controller,
                    cardsCount: properties.length,
                    numberOfCardsDisplayed: 3,
                    backCardOffset: const Offset(0, 40),
                    padding: const EdgeInsets.all(16.0),
                    allowedSwipeDirection: const AllowedSwipeDirection.only(right: true, left: true),
                    threshold: 50, // Reduced threshold for easier swiping
                    cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                      return PropertyCard(
                        key: ValueKey(properties[index].id),
                        property: properties[index],
                      );
                    },
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (direction == CardSwiperDirection.right) {
                        // Library quirk handling: depending on version, currentIndex might be next card. 
                        // previousIndex is the one swiped.
                        if (previousIndex >= 0 && previousIndex < properties.length) {
                           final propertyId = properties[previousIndex].id;
                           favoritesRepo.addFavorite(propertyId);
                           print('DEBUG: Added $propertyId to favorites');
                        }
                      }
                      return true;
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFE91E63))),
                error: (err, stack) => Center(
                  child: Text('Error: $err', style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            
            // Bottom Actions
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.close,
                    color: const Color(0xFFFF5252),
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                  ),
                  _ActionButton(
                    icon: Icons.favorite,
                    color: const Color(0xFFE91E63), // Pinkish red
                    isLarge: true,
                    onPressed: () => controller.swipe(CardSwiperDirection.right),
                  ),
                  // Optional: Super Like or Detail button could go here
                   _ActionButton(
                    icon: Icons.star,
                    color: const Color(0xFF2196F3),
                    onPressed: () {}, // Future: Super like
                    isSmall: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final bool isLarge;
  final bool isSmall;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.isLarge = false,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    double size = isLarge ? 70 : (isSmall ? 50 : 60);
    double iconSize = isLarge ? 32 : (isSmall ? 20 : 26);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[900], // Dark background for contrast
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.5), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: onPressed,
          child: Icon(icon, color: color, size: iconSize),
        ),
      ),
    );
  }
}
