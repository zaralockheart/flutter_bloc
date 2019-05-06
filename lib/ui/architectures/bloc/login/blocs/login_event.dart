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

class SendLoginResponse extends LoginEvent {
  final String data;

  SendLoginResponse({@required this.data})
      : assert(data != null),
        super([data]);
}

class LoginFail extends LoginEvent {
  final String error;

  LoginFail({@required this.error})
      : assert(error != null),
        super([error]);
}

class ClearLogin extends LoginEvent {}