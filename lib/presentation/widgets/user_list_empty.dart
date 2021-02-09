import 'package:flutter/material.dart';

class UserListEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Please push the refresh button',
        style: TextStyle(fontSize: 24, color: Colors.black),
      ),
    );
  }
}
