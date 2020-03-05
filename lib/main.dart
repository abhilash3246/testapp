import 'package:flutter/material.dart';
import 'package:testapp/bloc/fruit_bloc.dart';
import 'package:testapp/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: FruitBloc(),
      child: MaterialApp(
        title: 'Fruits',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          accentColor: Colors.redAccent,
        ),
        home: LoginPage(),
      ),
    );
  }
}

