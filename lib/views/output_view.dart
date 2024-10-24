import 'package:flutter/material.dart';
import 'package:atf_finals/models/grammar.dart';
import 'package:atf_finals/models/parser.dart';

class OutputScreen extends StatelessWidget {
  final Grammar grammar;

  OutputScreen({required this.grammar});

  @override
  Widget build(BuildContext context) {
    CFGParser parser = CFGParser(grammar, maxDepth: 5);

    // Generate strings starting from the start symbol (assumed to be "S")
    List<String> generatedStrings = parser.generateStrings("S");

    // Check if any strings were generated
    if (generatedStrings.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Generated Strings"),
        ),
        body: Center(
          child: Text(
            'No strings generated from the given grammar.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Generated Strings"),
      ),
      body: ListView.builder(
        itemCount: generatedStrings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'String ${index + 1} [ ${generatedStrings[index]} ]',
                style: TextStyle(fontSize: 18)
            ),
          );
        },
      ),
    );
  }
}
