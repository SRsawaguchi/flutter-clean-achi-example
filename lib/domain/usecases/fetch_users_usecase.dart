import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';
import 'package:flutter_clean_achi_example/domain/repositories/user_repository.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/core/usecase.dart';

class FetchUsersUsecase extends Usecase<FetchUsersUsecaseParams, List<User>> {
  final UserRepository repository;

  FetchUsersUsecase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(FetchUsersUsecaseParams params) {
    return repository.getUserList(params.count);
  }
}

class FetchUsersUsecaseParams extends Equatable {
  final int count;

  FetchUsersUsecaseParams(this.count);

  @override
  List<Object> get props => [count];
}
