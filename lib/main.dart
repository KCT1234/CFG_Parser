import 'package:flutter/material.dart';
import 'views/input_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CFG Parser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GrammarInputScreen(), // The initial screen where users create grammar
      debugShowCheckedModeBanner: false, // This line can be kept if you want to disable the debug banner.
    );
  }
}
