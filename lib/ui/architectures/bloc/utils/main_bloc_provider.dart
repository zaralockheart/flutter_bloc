import 'package:bloc_test/main_bloc.dart';
import 'package:flutter/material.dart';

class MainBlocProvider extends InheritedWidget {
  final MainBloc cartBloc;

  MainBlocProvider({
    Key key,
    MainBloc mainBloc,
    Widget child,
  })  : cartBloc = mainBloc ?? MainBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MainBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(MainBlocProvider) as MainBlocProvider)
          .cartBloc;
}