import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:krib/data/services/rentcast_service.dart';
import 'package:krib/data/services/mock_rentcast_service.dart';
import 'package:krib/domain/models/property_model.dart';

final rentCastServiceProvider = Provider<RentCastService>((ref) {
  final useMockData = dotenv.env['USE_MOCK_DATA'] == 'true';
  final apiKey = dotenv.env['RENTCAST_API_KEY'] ?? '';

  if (useMockData) {
    print('INFO: Using MockRentCastService (Mock Mode Enabled)');
    return MockRentCastService(http.Client(), apiKey: 'MOCK_KEY');
  }

  if (apiKey.isEmpty) {
    throw Exception('RENTCAST_API_KEY not found in .env');
  }
  return RentCastService(http.Client(), apiKey: apiKey);
});

final propertyFeedProvider = FutureProvider<List<Property>>((ref) async {
  final service = ref.watch(rentCastServiceProvider);
  // Hardcoded for now, can be dynamic later
  return service.getProperties(city: 'Austin', state: 'TX'); 
});
