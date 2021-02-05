abstract class Resource<T> {}

class Loading<T> implements Resource<T> {}

class Success<T> implements Resource<T> {
  final T data;
  Success([this.data]);
}

class Failure<T, E> implements Resource<T> {
  final E exception;
  Failure([this.exception]);
}
