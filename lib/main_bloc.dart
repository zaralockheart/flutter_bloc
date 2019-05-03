import 'package:bloc/bloc.dart';
import 'package:bloc_test/ui/login/blocs/login_bloc.dart';
import 'package:bloc_test/ui/login/blocs/login_event.dart';
import 'package:bloc_test/ui/login/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {

  LoginBloc _loginBloc = LoginBloc(
    repository: LoginRepository()
  );

  List<BlocProvider<Bloc>> get getBlocs => [
    BlocProvider<LoginBloc>(bloc: _loginBloc)
  ];

  clearData() {
    _loginBloc.dispatch(ClearLogin());
  }
}