import 'package:app/core/domain/response.dart';

class AreasResponse extends Response<List<Area>> {
  AreasResponse({int status, String timestamp, String message, List<Area> data})
      : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
        );
}

class Area {
  int id;
  String name;
  List<Coordinate> coordinates;

  Area(this.id, this.name, this.coordinates);
}

class Coordinate {
  double latitude;
  double longitude;

  Coordinate(this.latitude, this.longitude);
}
