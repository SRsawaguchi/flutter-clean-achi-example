import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/user_list_empty.dart';
import './widgets/user_list_error.dart';
import './widgets/user_list_loading.dart';
import './bloc/users_cubit.dart';
import './bloc/users_state.dart';
import './widgets/user_list.dart';

class UsersPage extends StatelessWidget {
  final int usersCount;

  UsersPage(this.usersCount);

  static MaterialPageRoute route(UsersCubit cubit, int usersCount) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => cubit,
        child: UsersPage(usersCount),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      floatingActionButton: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) => FloatingActionButton(
          onPressed: () => {
            if (!(state is UsersLoading))
              {context.read<UsersCubit>().fetchUsers(usersCount)}
          },
          child: (state is UsersLoading)
              ? Icon(Icons.remove)
              : Icon(Icons.refresh),
        ),
      ),
      body: BlocListener<UsersCubit, UsersState>(
        listener: (context, state) {
          if (state is UsersError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            if (state is UsersInit) {
              return UserListEmpty();
            } else if (state is UsersError) {
              return UserListError(state.message);
            } else if (state is UsersAvailable) {
              return UserList(state.users);
            }
            return UserListLoading();
          },
        ),
      ),
    );
  }
}
