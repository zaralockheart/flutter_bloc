import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_event.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_state.dart';
import 'package:bloc_test/ui/architectures/bloc/login/login_repository.dart';
import 'package:dio/dio.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({this.repository});

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginEmpty();

  Future callApi(String username) async {
    try {
      await repository.fetchTodo().then((res) {
        this.dispatch(SendLoginResponse(data: username));
      });
    } on DioError catch (e) {
      this.dispatch(
          LoginFail(error: e.response.statusCode.toString()));
      rethrow;
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      yield LoginLoading();
      try {
        var response = await repository.fetchTodo();
        String responseString = response.data.toString();

        yield LoginSuccess(username: responseString);
      } on DioError catch (e) {
        yield LoginError(error: e.response.statusCode.toString());
      }
    }

    if (event is ClearLogin) {
      yield LoginEmpty();
    }

    if (event is SendLoginResponse) {
      yield LoginSuccess(username: event.data);
    }

    if (event is LoginFail) {
      yield LoginError(error: event.error);
    }
  }
}
