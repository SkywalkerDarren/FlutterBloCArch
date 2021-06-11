import 'package:meta/meta.dart';

@sealed
abstract class Result<T> {
  R whenWithResult<R>(
    R Function(_Success<T>) success,
    R Function(_Error) error,
  ) {
    if (this is _Success<T>) {
      return success(this as _Success<T>);
    } else if (this is _Error) {
      return error(this as _Error);
    } else {
      throw new Exception('Unhandled part, could be anything');
    }
  }

  Result._();
  factory Result.success(T value) => _Success(value);
  factory Result.error({Exception? exception, Error? error}) =>
      _Error(exception, error);
}

class _Success<T> extends Result<T> {
  final T value;

  _Success(this.value) : super._();
}

class _Error<T> extends Result<T> {
  final Exception? exception;
  final Error? error;
  _Error(this.exception, this.error) : super._();
}
