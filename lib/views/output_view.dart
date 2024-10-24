import 'package:flutter/material.dart';
import 'package:atf_finals/models/grammar.dart';
import 'package:atf_finals/models/parser.dart';

class OutputScreen extends StatelessWidget {
  final Grammar grammar;

  OutputScreen({required this.grammar});

  @override
  Widget build(BuildContext context) {
    CFGParser parser = CFGParser(grammar, maxDepth: 5);  // Adjust maxDepth as needed

    // Generate strings starting from the start symbol (S)
    Set<String> generatedStrings = parser.generateStrings("S");

    // Sort the strings based on length, and keep the first 10 varied outputs
    List<String> sortedStrings = generatedStrings.toList()
      ..sort((a, b) => a.length.compareTo(b.length));
    sortedStrings = sortedStrings.take(10).toList();  // Take the first 10 strings

    // Check if any strings were generated
    if (sortedStrings.isEmpty) {
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
        itemCount: sortedStrings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'String ${index + 1} [ ${sortedStrings[index]} ]',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}