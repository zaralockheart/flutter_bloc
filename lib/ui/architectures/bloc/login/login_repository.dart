import 'dart:async';

import 'package:bloc_test/util/dio.dart';
import 'package:dio/dio.dart';

class LoginRepository {

  Future<Response> fetchTodo() => dio.get('https://jsonplaceholder.typicode.com/todos/1');

}