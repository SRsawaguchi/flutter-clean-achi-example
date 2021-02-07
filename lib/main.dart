import 'package:flutter_clean_achi_example/data/datasources/random_user_generator_api.dart';
import 'package:flutter_clean_achi_example/domain/usecases/fetch_users_usecase.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_cubit.dart';
import 'package:flutter_clean_achi_example/presentation/users_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_clean_achi_example/data/repositories/user_repository_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final http.Client _client = http.Client();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return _usersRoute();
        }
        throw Exception('There is no such page: ${settings.name}');
      },
    );
  }

  MaterialPageRoute _usersRoute() {
    const USERS_COUNT = 5;
    final api = RandomUserGeneratorApi(_client);
    final repository = UserRepositoryImpl(api);
    final usecase = FetchUsersUsecase(repository);
    final cubit = UsersCubit(usecase);
    return UsersPage.route(cubit, USERS_COUNT);
  }
}
