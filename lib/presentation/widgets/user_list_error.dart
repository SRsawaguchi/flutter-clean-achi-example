import 'package:flutter/material.dart';

class UserListError extends StatelessWidget {
  final String message;

  UserListError(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 24, color: Colors.red),
      ),
    );
  }
}
