import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationState {
  final String city;
  final String state;
  final String? zipCode;
  final bool isSet;

  const LocationState({
    this.city = '',
    this.state = '',
    this.zipCode,
    this.isSet = false,
  });

  LocationState copyWith({
    String? city,
    String? state,
    String? zipCode,
    bool? isSet,
  }) {
    return LocationState(
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isSet: isSet ?? this.isSet,
    );
  }
}

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() {
    return const LocationState();
  }

  void setLocation({required String city, required String state, String? zipCode}) {
    this.state = LocationState(
      city: city,
      state: state,
      zipCode: zipCode,
      isSet: true,
    );
  }
  
  void clearLocation() {
    state = const LocationState();
  }
}

final locationProvider = NotifierProvider<LocationNotifier, LocationState>(LocationNotifier.new);
