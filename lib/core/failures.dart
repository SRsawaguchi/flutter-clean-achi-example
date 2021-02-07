import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return message;
  }

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server Error');
}
