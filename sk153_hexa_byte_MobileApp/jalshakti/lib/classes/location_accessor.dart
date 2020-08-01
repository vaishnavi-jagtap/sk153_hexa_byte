import 'package:geolocator/geolocator.dart';

class LocationAccessor {
  double _latitude, _longitude;
  String _error;
  LocationAccessor() {
    _latitude = 0.0;
    _longitude = 0.0;
    _error = "";
  }

  Future<bool> isGPSEnabled() async {
    return await Geolocator().isLocationServiceEnabled();
  }

  Future<bool> fetchLocation() async {
    if (await isGPSEnabled()) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      this._latitude = position.latitude;
      this._longitude = position.longitude;
      return true;
    } else {
      setError("Please enable GPS");
      return false;
    }
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String _address = "";
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(lat, lng);

      Placemark place = p[0];

      _address =
          "${place.locality},\n${place.subAdministrativeArea}- ${place.postalCode}\n${place.administrativeArea},\n${place.country}";
    } catch (e) {
      //print("Error from location accessor:${e}");
      _address = "No internet connection\nPlease enable internet connection";
    }
    return _address;
  }

  void setError(message) {
    _error = message;
  }

  String getError() {
    return this._error;
  }

  double getLongitude() {
    return this._longitude;
  }

  double getLatitude() {
    return this._latitude;
  }
}
