import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/ui/login/blocs/login_event.dart';
import 'package:bloc_test/ui/login/blocs/login_state.dart';
import 'package:bloc_test/ui/login/login_repository.dart';
import 'package:dio/dio.dart';

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
