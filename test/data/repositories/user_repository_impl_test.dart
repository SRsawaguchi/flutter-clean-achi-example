import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_achi_example/core/exceptions.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/data/datasources/random_user_generator_api.dart';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:flutter_clean_achi_example/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../datasources/random_user_generator_sample_response.dart.dart';

class MockRandomUserGeneratorApi extends Mock
    implements RandomUserGeneratorApi {}

void main() {
  final json = jsonDecode(RandomUserGeneratorSampleResponse.RESULT_JSON);
  final userList = UserModel.userListFromJson(json);
  final userCount = RandomUserGeneratorSampleResponse.RESULT_USER_COUNT;

  MockRandomUserGeneratorApi mockApi;
  UserRepositoryImpl repository;

  setUp(() {
    mockApi = MockRandomUserGeneratorApi();
    repository = UserRepositoryImpl(mockApi);
  });

  test('should return List<User> when the call to remote api is successful',
      () async {
    when(mockApi.fetchRandomUsers(userCount)).thenAnswer((_) async => userList);

    final result = await repository.getUserList(userCount);

    verify(mockApi.fetchRandomUsers(userCount));
    expect(result, equals(Right(userList)));
  });

  test('should ServerFeilure when the call to remote api is unsuccessful',
      () async {
    when(mockApi.fetchRandomUsers(any)).thenThrow(ServerException());

    final result = await repository.getUserList(userCount);

    verify(mockApi.fetchRandomUsers(userCount));
    expect(result, equals(Left(ServerFailure())));
  });
}
