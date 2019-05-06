import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginSuccess extends LoginState {
  final String username;

  LoginSuccess({@required this.username})
      : assert(username != null),
        super([username]);
}

class LoginLoading extends LoginState {}

class LoginEmpty extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError({@required this.error})
      : assert(error != null),
        super([error]);
}