import 'package:flutter/material.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem(this.user);

  @override
  Widget build(BuildContext context) {
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
  }
}
