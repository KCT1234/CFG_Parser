import 'package:flutter/material.dart';
import 'package:atf_finals/models/grammar.dart';
import 'output_view.dart';

class GrammarInputScreen extends StatefulWidget {
  @override
  _GrammarInputScreenState createState() => _GrammarInputScreenState();
}

class _GrammarInputScreenState extends State<GrammarInputScreen> {
  List<TextEditingController> _nonTerminalControllers = [];
  List<TextEditingController> _productionControllers = [];
  Grammar _grammar = Grammar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create CFG"),
      ),
      body: ListView.builder(
        itemCount: _nonTerminalControllers.length + 1,
        itemBuilder: (context, index) {
          if (index < _nonTerminalControllers.length) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nonTerminalControllers[index],
                    decoration: InputDecoration(labelText: "Non-terminal"),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _productionControllers[index],
                    decoration: InputDecoration(labelText: "Production"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _nonTerminalControllers.removeAt(index);
                      _productionControllers.removeAt(index);
                    });
                  },
                )
              ],
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                setState(() {
                  _nonTerminalControllers.add(TextEditingController());
                  _productionControllers.add(TextEditingController());
                });
              },
              child: Text("Add Rule"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Clear any previous grammar before adding new rules
          _grammar = Grammar();

          for (int i = 0; i < _nonTerminalControllers.length; i++) {
            String nonTerminal = _nonTerminalControllers[i].text;
            String production = _productionControllers[i].text;

            // Make sure both non-terminal and production are not empty
            if (nonTerminal.isNotEmpty && production.isNotEmpty) {
              _grammar.addRule(nonTerminal, production);
            }
          }

          // Debugging output: Print grammar rules to console
          _grammar.rules.forEach((key, value) {
            print('Non-terminal: $key, Productions: $value');
          });

          // Navigate to the output screen only if there are rules
          if (_grammar.rules.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OutputScreen(grammar: _grammar),
              ),
            );
          } else {
            // Show a message if no valid grammar rules were added
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please add at least one valid rule!')),
            );
          }
        },
      ),
    );
  }
}
