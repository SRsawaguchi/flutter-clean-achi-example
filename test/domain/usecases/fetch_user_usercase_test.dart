import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:flutter_clean_achi_example/domain/repositories/user_repository.dart';
import 'package:flutter_clean_achi_example/domain/usecases/fetch_user_usercase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasources/random_user_generator_sample_response.dart.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final json = jsonDecode(RandomUserGeneratorSampleResponse.RESULT_JSON);
  final userList = UserModel.userListFromJson(json);
  final userCount = RandomUserGeneratorSampleResponse.RESULT_USER_COUNT;

  MockUserRepository mockRepository;
  FetchUserUsercase usecase;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = FetchUserUsercase(mockRepository);
  });

  test('should return List<User> from repository', () async {
    when(mockRepository.getUserList(any))
        .thenAnswer((_) async => Right(userList));
    final params = FetchUserUsercaseParams(userCount);

    final result = await usecase(params);

    verify(mockRepository.getUserList(userCount));
    expect(result, equals(Right(userList)));
  });

  test(
      'should returl ServerFailure when retreving data from repository is unsuccessful',
      () async {
    when(mockRepository.getUserList(any))
        .thenAnswer((_) async => Left(ServerFailure()));
    final params = FetchUserUsercaseParams(userCount);

    final result = await usecase(params);

    verify(mockRepository.getUserList(userCount));
    expect(result, equals(Left(ServerFailure())));
  });
}
