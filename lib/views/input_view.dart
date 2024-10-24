import 'package:flutter/material.dart';
import 'package:atf_finals/models/grammar.dart'; // Ensure this exists
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
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Enter Non-terminals and Productions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _nonTerminalControllers.length + 1,
                itemBuilder: (context, index) {
                  if (index < _nonTerminalControllers.length) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nonTerminalControllers[index],
                            decoration: InputDecoration(
                              labelText: "Non-terminal",
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _productionControllers[index],
                            decoration: InputDecoration(
                              labelText: "Production",
                            ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // Clear existing grammar
          _grammar = Grammar();
          
          // Validate input
          for (int i = 0; i < _nonTerminalControllers.length; i++) {
            String nonTerminal = _nonTerminalControllers[i].text.trim();
            String production = _productionControllers[i].text.trim();

            // Ensure both fields are not empty
            if (nonTerminal.isNotEmpty && production.isNotEmpty) {
              _grammar.addRule(nonTerminal, production);
            }
          }

          // Ensure at least one valid rule exists
          if (_grammar.rules.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OutputScreen(grammar: _grammar),
              ),
            );
          } else {
            // Display error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please add at least one valid rule!')),
            );
          }
        },
      ),
    );
  }
}
