import 'package:flutter/material.dart';
import 'package:atf_finals/models/grammar.dart';
import 'package:atf_finals/models/parser.dart';
import 'package:atf_finals/models/parse_tree.dart'; // Ensure this path is valid
import 'package:atf_finals/views/parsetree_view.dart'; // Ensure this exists

class OutputScreen extends StatelessWidget {
  final Grammar grammar;

  OutputScreen({required this.grammar});

  @override
  Widget build(BuildContext context) {
    CFGParser parser = CFGParser(grammar, maxDepth: 5); // Adjust maxDepth as needed
    Set<String> generatedStrings = parser.generateStrings("S");

    List<String> sortedStrings = generatedStrings.toList()
      ..sort((a, b) => a.length.compareTo(b.length));
    sortedStrings = sortedStrings.take(10).toList(); // Take the first 10 strings

    if (sortedStrings.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Generated Strings and Parse Tree Output",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4A90E2), // Primary color
                  Color(0xFFB3C8E5), // Secondary color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 10, // Add shadow for depth
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
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
        title: Text(
          "Generated Strings and Parse Tree Output",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF4A90E2), // Primary color
                Color(0xFFB3C8E5), // Secondary color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10, // Add shadow for depth
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sortedStrings.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'String ${index + 1}: [ ${sortedStrings[index]} ]',
                          style: TextStyle(fontSize: 18, fontFamily: 'Lora'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParseTreeScreen(
                                string: sortedStrings[index],
                                parser: parser,
                              ),
                            ),
                          );
                        },
                        child: Text("Show Parse Tree"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
