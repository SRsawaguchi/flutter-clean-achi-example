import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_cubit.dart';
import 'package:flutter_clean_achi_example/presentation/bloc/users_state.dart';

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
              return Center(
                  child: Text(
                'Please push the refresh button',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ));
            } else if (state is UsersError) {
              return Center(
                  child: Text(
                state.message,
                style: TextStyle(fontSize: 24, color: Colors.red),
              ));
            } else if (state is UsersAvailable) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.thumbnailUrl),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
