import 'dart:async';

import 'package:bloc/bloc.dart';
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

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  // TODO: implement initialState
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      yield LoginLoading();
      try {
        Future.delayed(Duration(seconds: 1));
//        throw "Error";
        yield LoginSuccess(username: event.username);
      } catch (e) {
        yield LoginError(error: e);
      }
    } else if (event is ClearLogin ) {
      yield LoginEmpty();
    }
  }
}
