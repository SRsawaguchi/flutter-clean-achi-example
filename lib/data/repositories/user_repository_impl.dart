import 'package:dartz/dartz.dart';
import 'package:flutter_clean_achi_example/core/exceptions.dart';
import 'package:flutter_clean_achi_example/data/datasources/random_user_generator_api.dart';

import 'package:flutter_clean_achi_example/domain/entities/user.dart';
import 'package:flutter_clean_achi_example/domain/repositories/user_repository.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';

class UserRepositoryImpl extends UserRepository {
  final RandomUserGeneratorApi api;

  UserRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<User>>> getUserList(int count) async {
    try {
      final userList = await api.fetchRandomUsers(count);
      return Right(userList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
