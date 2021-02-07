import 'package:dartz/dartz.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';
import 'package:flutter_clean_achi_example/domain/repositories/user_repository.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/core/usecase.dart';

class FetchUserUsercase extends Usecase<FetchUserUsercaseParams, List<User>> {
  final UserRepository repository;

  FetchUserUsercase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(FetchUserUsercaseParams params) {
    return repository.getUserList(params.count);
  }
}

class FetchUserUsercaseParams {
  int count;

  FetchUserUsercaseParams(this.count);
}
