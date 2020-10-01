import 'package:dartz/dartz.dart';

Either<String, T> nullToE<T>(T? input, String errorMsg) {
  return input == null ? Left(errorMsg) : Right(input);
}
