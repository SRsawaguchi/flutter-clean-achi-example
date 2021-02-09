import 'package:flutter/material.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';
import 'package:flutter_clean_achi_example/presentation/widgets/user_list_item.dart';

class UserList extends StatelessWidget {
  final List<User> users;

  UserList(this.users);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => UserListItem(users[index]),
    );
  }
}
