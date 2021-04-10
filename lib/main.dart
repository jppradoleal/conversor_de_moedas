import 'package:conversor_de_moedas/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.yellow,
        accentColor: Colors.yellow,
        primaryColorDark: Colors.yellow,
        hintColor: Colors.amber,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.amber,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
            prefixStyle: TextStyle(color: Colors.amber)),
      ),
      home: Home(),
    );
  }
}
