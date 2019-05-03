import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class FetchLogin extends LoginEvent {
  final String username;

  FetchLogin({@required this.username})
      : assert(username != null),
        super([username]);
}

class ClearLogin extends LoginEvent {}