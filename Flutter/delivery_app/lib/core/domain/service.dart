import 'package:app/core/domain/response.dart';

class ServicesResponse extends ResponsePagination<List<Service>> {
  ServicesResponse(
      {int status, String timestamp, String message, List<Service> data, Pagination pagination})
      : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );
}

class Service {
  int id;
  String name;
  String description;
  String image;

  Service({this.id, this.name, this.description, this.image});
}
