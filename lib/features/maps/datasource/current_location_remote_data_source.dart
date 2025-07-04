import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../core/consts_and_enums/consts/google_maps_keys.dart';
import '../../../core/utils/string_helpers.dart';
import '../model/open_street_map/open_street_map_response.dart';

abstract class CurrentLocationRemoteDataSource {
  Future<Position> getCurrentLocation();
  Future<String> getDistance({
    required String originLat,
    required String originLng,
    required String destLat,
    required String destLng,
  });
  // Future<Position> getCurrentLocation();
  Future<OpenStreetMapResponse> getCurrentAddress(double lat, double lon, {String? altName});
}

@Injectable(as: CurrentLocationRemoteDataSource)
class CurrentLocationRemoteDataSourceImpl
    extends CurrentLocationRemoteDataSource {
  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // throw const LocationServiceDisabledException();
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw const PermissionDeniedException(
            'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      throw const PermissionDeniedException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  @override
  Future<OpenStreetMapResponse> getCurrentAddress(
      double lat, double lon, {String? altName}) async {
    print("lat: $lat");
    print("lon: $lon");
    // const String googelApiKey = googleApiKeyTestNew;
    const isDebugMode = true;
    final api = GoogleGeocodingApi(googleApiKey, isLogged: isDebugMode);
    final reversedSearchResults = await api.reverse(
      '$lat,$lon',
      language: 'id',
    );
    var longAddress = reversedSearchResults.results.first.formattedAddress;
    var placeId = reversedSearchResults.results.first.placeId;

    var isPlusCodeLong = isPlusCodeCheck(longAddress);
    if(isPlusCodeLong){
      longAddress = "Alamat tidak diketahui";
    }

    /// Ga bisa, ga beraturan
    // reversedSearchResults.results.first.addressComponents.forEach((element) {
    //   log('shortName address: ${element.shortName}');
    //   log('longName address: ${element.longName}');
    // });
    // var addressComponents = reversedSearchResults.results.first.addressComponents.toList();
    // var shortAddress = (addressComponents.length > 1 ? addressComponents[1].shortName : altName) ?? "";
    // if(isPlusCodeCheck(shortAddress)){
    //   shortAddress = "Alamat tidak diketahui";
    // }
    print("longAddress: $longAddress");
    print("placeId: $placeId");
    // print("shortAddress: $shortAddress");
    // var nonEmptyLongAddress = reversedSearchResults.results.first.addressComponents.
    // var titleName =  reversedSearchResults.results.first.addressComponents.firstOrNull?.shortName;

    // log('long address: $longAddress');
    // var result =
    //     await http.get(Uri.http("nominatim.openstreetmap.org", "/reverse", {
    //   "format": "jsonv2",
    //   "lat": lat.toString(),
    //   "lon": lon.toString(),
    // }));

    // if (result.statusCode != 200) throw ServerException();
    // // todo change to simple string
    // log("result.body OpenStreetMap: ${result.body}");
    return OpenStreetMapResponse(
        latitude: lat,
        longitude: lon,
        // simpleName: longAddress,
        displayName: longAddress);
  }

  Future<String> getDistance({
    required String originLat,
    required String originLng,
    required String destLat,
    required String destLng,
  }) async {
    String apiKey = googleApiKeyTestNew;
    String origin = "$originLat,$originLng"; // Jakarta
    String destination = "$destLat,$destLng"; // Surabaya

    String url = "https://maps.googleapis.com/maps/api/distancematrix/json?"
        "origins=$origin&destinations=$destination&key=$apiKey";

    print("URL get jarak: $url");

    var response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    log("data google maps: $data");

    if (data['status'] == 'OK') {
      var distance = data['rows'][0]['elements'][0]['distance']['text'];
      return distance;
    } else {
      print("Gagal mendapatkan jarak");
      return "";
    }
  }
}
