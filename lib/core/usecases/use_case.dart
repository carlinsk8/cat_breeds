import 'package:dartz/dartz.dart';

import '../error/failure.dart';

typedef Callback<T> = Function(T);

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params, {Callback? callback});
}

class NoParams {
}
