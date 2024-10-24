import 'package:flutter/material.dart';
import 'package:atf_finals/models/parser.dart';

class ParseTreeScreen extends StatelessWidget {
  final String string;
  final CFGParser parser;

  ParseTreeScreen({required this.string, required this.parser});

  @override
  Widget build(BuildContext context) {
    // Try to generate the parse tree for the input string using the parser
    String parseTree;
    
    try {
      parseTree = parser.generateParseTree(string);
    } catch (e) {
      // If there's an error generating the parse tree, show an error message
      parseTree = "Error generating parse tree: ${e.toString()}";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Parse Tree for \"$string\""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            parseTree,
            style: TextStyle(fontSize: 16, fontFamily: 'Courier'),
          ),
        ),
      ),
    );
  }
}
