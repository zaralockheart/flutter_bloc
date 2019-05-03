// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:bloc_test/util/dio.dart';
import 'package:bloc_test/main_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/ui/login/login.dart';

class DioMock extends Mock implements Dio {}

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    dio = DioMock();

    when(dio.get('https://jsonplaceholder.typicode.com/todos/1')).thenAnswer(
            (_) => throw DioError(response: Response(statusCode: 400)));

    await tester.pumpWidget(MyApp(
      mainBloc: MainBloc(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('No Username'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('400'), findsOneWidget);

    when(dio.get('https://jsonplaceholder.typicode.com/todos/1')).thenAnswer(
            (_) => throw DioError(response: Response(statusCode: 500)));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('500'), findsOneWidget);

    when(dio.get('https://jsonplaceholder.typicode.com/todos/1')).thenAnswer(
            (_) => Future.value(Response(data: json.decode("""
            {
              "userId": 1, 
              "id": 1, 
              "title": "delectus aut autem", 
              "completed": false
            }"""))));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text("{userId: 1, id: 1, title: delectus aut autem, completed: false}"), findsOneWidget);

  });
}
