
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/services/network_info/network_info.dart';
import '../datasource/current_location_remote_data_source.dart';
import '../model/open_street_map/open_street_map_response.dart';

@injectable
class LocationRepository {
  final CurrentLocationRemoteDataSource currentLocationRemoteDataSource;
  final NetworkInfo networkInfo;

  LocationRepository(
      {required this.currentLocationRemoteDataSource,
      required this.networkInfo});

  Future<Either<Failure, Position>> getCurrentPosition() async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());
    try {
      final position = await currentLocationRemoteDataSource.getCurrentLocation();
      // authLocalDataSource.cacheLoginResponse(remoteTrivia);
      print("LATITUDE FROM REPO: ${position.latitude}");
      return Right(position);
    } on LocationServiceDisabledException {
      print("LATITUDE FROM REPO: LocationServiceDisabledFailure");
      return Left(LocationServiceDisabledFailure());
    } on PermissionDeniedException {
      print("LATITUDE FROM REPO: PermissionDeniedFailure");
      return Left(PermissionDeniedFailure());
    }
  }

  Future<Either<Failure, OpenStreetMapResponse>> getCurrentAddress(double latitude, double longitude, {String? altName}) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());
    try {

      final address = await currentLocationRemoteDataSource.getCurrentAddress(latitude, longitude, altName: altName);
      // authLocalDataSource.cacheLoginResponse(remoteTrivia);
      // print("address: $address");
      return Right(address);
    } on ServerException {
      print("Error di request");
      return Left(OpenStreetMapServerFailure());
    }
  }

  Future<Either<Failure, double>> getDistance({
    required String originLat,
    required String originLng,
    required String destLat,
    required String destLng,
  }) async {
    if (!(await networkInfo.isConnected)) return Left(NoInternetFailure());
    try {

      double startLatitude = double.tryParse(originLat) ?? 0.0;
      double startLongitude = double.tryParse(originLng) ?? 0.0;
      double endLatitude = double.tryParse(destLat) ?? 0.0;
      double endLongitude = double.tryParse(destLng) ?? 0.0;

      double distance = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude,
      );
      // final distanceString = await currentLocationRemoteDataSource.getDistance(
      //     originLat: originLat,
      //     originLng: originLng,
      //     destLat: destLat,
      //     destLng: destLng,
      // );
      // final distance = double.tryParse(distanceString.isNotEmpty ? distanceString : "0.0") ?? 0.0;
      // authLocalDataSource.cacheLoginResponse(remoteTrivia);
      print("distance: $distance");
      return Right(distance);
    } on ServerException {
      print("Error di get distance");
      return Left(OpenStreetMapServerFailure());
    }
  }
}
