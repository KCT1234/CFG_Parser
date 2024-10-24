import 'package:flutter/material.dart';
import 'views/input_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CFG Parser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GrammarInputScreen(), // The initial screen where users create grammar
    );
  }
}
