import 'package:location/location.dart';

class LocationService {
  LocationService._();

  Future<bool> checkLocationServiceEnabled() async {
    Location location = Location();
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<PermissionStatus> getLocationPermission() async {
    Location location = Location();
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    return permissionGranted;
  }

  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled = await checkLocationServiceEnabled();
    if (serviceEnabled) {
      PermissionStatus permissionGranted = await getLocationPermission();
      if (permissionGranted == PermissionStatus.granted) {
        Location location = Location();
        return await location.getLocation();
      } else {
        throw Exception('Location permissions are denied');
      }
    } else {
      throw Exception('Location services are disabled');
    }
  }
}
