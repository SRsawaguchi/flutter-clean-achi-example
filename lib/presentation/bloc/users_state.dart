import 'package:equatable/equatable.dart';
import 'package:flutter_clean_achi_example/domain/entities/user.dart';

class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInit extends UsersState {}

class UsersLoading extends UsersState {}

class UsersAvailable extends UsersState {
  final List<User> users;

  UsersAvailable(this.users);

  @override
  List<Object> get props => [users];
}

class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}
