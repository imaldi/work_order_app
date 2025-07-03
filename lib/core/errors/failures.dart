abstract class Failure {
  final String message;
  const Failure(this.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message = "Database Error");
}

class NoInternetFailure extends Failure {
  NoInternetFailure({String? message}) : super(message = "No Internet");
}




class LocationServiceDisabledFailure extends Failure {
  LocationServiceDisabledFailure({String? message}) : super(message = "GPS Turned Off");
}

class PermissionDeniedFailure extends Failure {
  PermissionDeniedFailure({String? message}) : super(message = "Permission Denied");
}

class OpenStreetMapServerFailure extends Failure {
  OpenStreetMapServerFailure({String? message}) : super(message = "OSM Failure");
}
