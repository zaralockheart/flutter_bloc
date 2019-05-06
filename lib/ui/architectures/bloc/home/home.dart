import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_bloc.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_event.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_state.dart';
import 'package:bloc_test/ui/architectures/bloc/utils/main_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _counterBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<LoginEvent, LoginState>(
          bloc: _counterBloc,
          builder: (BuildContext context, LoginState state) {
            if (state is LoginSuccess) {
              return Text("${state.username}");
            }

            if (state is LoginError) {
              return Text("${state.error}");
            }

            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MainBlocProvider.of(context).clearData();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
