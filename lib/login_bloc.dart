import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/login_repository.dart';
import 'package:dio/dio.dart';
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

  final LoginRepository repository;

  LoginBloc({this.repository});
  @override
  // TODO: implement initialState
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      yield LoginLoading();
      try {
        var response = await repository.fetchTodo();
        String responseString = response.data.toString();

        yield LoginSuccess(username:responseString);
      } on DioError catch (e) {
        yield LoginError(error: e.response.statusCode.toString());
      }
    } else if (event is ClearLogin ) {
      yield LoginEmpty();
    }
  }
}
