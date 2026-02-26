import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<({double latitude, double longitude})> getLatLong() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return (latitude: 0.0, longitude: 0.0);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return (latitude: 0.0, longitude: 0.0);
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return (latitude: position.latitude, longitude: position.longitude);
  }
}
