import 'package:bloc_test/main_bloc.dart';
import 'package:bloc_test/ui/architectures/bloc/login/login.dart';
import 'package:bloc_test/ui/architectures/bloc/utils/main_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => {
      runApp(MyApp(
        mainBloc: MainBloc(),
      ))
    };

class MyApp extends StatelessWidget {

  final MainBloc mainBloc;

  const MyApp({Key key, this.mainBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MainBlocProvider(
      mainBloc: mainBloc,
      child: BlocProviderTree(
          blocProviders: mainBloc.getBlocs,
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BlocCounterPage(),
          )
      ),
    );
  }
}