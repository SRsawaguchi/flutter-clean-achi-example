import 'package:dartz/dartz.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';

abstract class Usecase<P, O> {
  Future<Either<Failure, O>> call(P params);
}
