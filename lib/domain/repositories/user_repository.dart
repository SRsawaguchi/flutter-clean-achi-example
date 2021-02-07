import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUserList(int count);
}
