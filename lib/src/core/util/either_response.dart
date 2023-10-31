import 'package:either_dart/either.dart';

typedef EitherResponse<T> = Future<Either<Exception, T>>;
