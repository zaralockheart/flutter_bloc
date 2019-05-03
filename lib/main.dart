import 'package:bloc_test/login_bloc.dart';
import 'package:bloc_test/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => {
	runApp(
      MyApp(
    mainBloc: MainBloc(),
  ))
};

class MyApp extends StatelessWidget {

  final MainBloc mainBloc;

  const MyApp({Key key, this.mainBloc}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProviderTree(
        blocProviders: mainBloc.getBlocs,
        child: BlocCounterPage(),
      ),
    );
  }
}

class BlocCounterPage extends StatefulWidget {
  BlocCounterPage({Key key}) : super(key: key);

  @override
  _BlocCounterPageState createState() => _BlocCounterPageState();
}

class _BlocCounterPageState extends State<BlocCounterPage> {

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
            Text('You have pushed the button this many times:'),
            BlocBuilder<LoginEvent, LoginState>(
              bloc: _counterBloc,
              builder: (BuildContext context, LoginState state) {
                if (state is LoginSuccess) {
                  return Text("${state.username}");
                }

                if (state is LoginError) {
                  return Text("${state.error}");
                }

                return Text("No Username");
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counterBloc.dispatch(FetchLogin(username: "Yusuf"));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
