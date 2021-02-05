class Response<T> {
  int status;
  String timestamp;
  String message;
  T data;

  Response({this.status, this.timestamp, this.message, this.data});
}

class ResponsePagination<T> {
  int status;
  String timestamp;
  String message;
  T data;
  Pagination pagination;

  ResponsePagination({this.status, this.timestamp, this.message, this.data, this.pagination});
}

class Pagination {
  int totalElements;
  int totalPages;
  int page;
  int numberOfElements;

  Pagination({this.totalElements, this.totalPages, this.page, this.numberOfElements});
}
