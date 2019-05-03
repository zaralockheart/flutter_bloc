import 'package:bloc/bloc.dart';
import 'package:bloc_test/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc {

  LoginBloc _loginBloc = LoginBloc();

  List<BlocProvider<Bloc>> get getBlocs => [
    BlocProvider<LoginBloc>(bloc: _loginBloc)
  ];

  clearData() {
    _loginBloc.dispatch(ClearLogin());
  }
}