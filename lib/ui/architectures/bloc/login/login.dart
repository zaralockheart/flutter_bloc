import 'package:bloc_test/main_bloc.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_bloc.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_event.dart';
import 'package:bloc_test/ui/architectures/bloc/login/blocs/login_state.dart';
import 'package:bloc_test/ui/architectures/bloc/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterPage extends StatefulWidget {
  BlocCounterPage({Key key}) : super(key: key);

  @override
  _BlocCounterPageState createState() => _BlocCounterPageState();
}

class _BlocCounterPageState extends State<BlocCounterPage> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc _counterBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Streams'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<LoginEvent, LoginState>(
              bloc: _counterBloc,
              builder: (BuildContext context, LoginState state) {
                if (state is LoginSuccess) {
                  return Text("${state.username}");
                }

                if (state is LoginError) {
                  return Text("${state.error}");
                }

                return Center(
                  child: TextFormField(
                    key: Key('username'),
                    controller: controller,
                    decoration: InputDecoration(
                        labelText: 'Enter your username'
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterBloc.callApi(controller.text).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }).catchError((_){});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
