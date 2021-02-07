import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_achi_example/core/failures.dart';
import 'package:flutter_clean_achi_example/data/models/user_model.dart';
import 'package:flutter_clean_achi_example/domain/usecases/fetch_users_usecase.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_cubit.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../data/datasources/random_user_generator_sample_response.dart.dart';

class MockUsersUsecase extends Mock implements FetchUsersUsecase {}

void main() {
  final json = jsonDecode(RandomUserGeneratorSampleResponse.RESULT_JSON);
  final userList = UserModel.userListFromJson(json);
  final userCount = RandomUserGeneratorSampleResponse.RESULT_USER_COUNT;

  MockUsersUsecase usecase;
  UsersCubit cubit;

  setUp(() {
    usecase = MockUsersUsecase();
    cubit = UsersCubit(usecase);
  });

  test('initial state should be UsersInit', () {
    expect(cubit.state, isA<UsersInit>());
  });

  blocTest(
    'should emit UsersAvailable when repository returns valid data',
    build: () {
      when(usecase(any)).thenAnswer((_) async => Right(userList));
      return cubit;
    },
    act: (UsersCubit cubit) => cubit.fetchUsers(userCount),
    expect: [
      UsersLoading(),
      UsersAvailable(userList),
    ],
  );

  blocTest(
    'should emit UsersError when repository returns ServerFeilure',
    build: () {
      when(usecase(any)).thenAnswer((_) async => Left(ServerFailure()));
      return cubit;
    },
    act: (UsersCubit cubit) => cubit.fetchUsers(userCount),
    expect: [
      UsersLoading(),
      UsersError(ServerFailure().message),
    ],
  );
}
