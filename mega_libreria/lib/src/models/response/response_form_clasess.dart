class SuccessResponse<Data> {
  final Data data;
  final String message;

  SuccessResponse({this.data, this.message});
}

class FailResponse<Data> {
  final Data data;
  final String message;

  FailResponse({this.data, this.message});
}

enum ErrorType{
  noInternet,
  unknown
}