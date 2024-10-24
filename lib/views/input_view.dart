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
        title: Text(
          "CFG - Context Free Grammar",
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Enter Non-terminals and Productions:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _nonTerminalControllers.length + 1,
                itemBuilder: (context, index) {
                  if (index < _nonTerminalControllers.length) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _nonTerminalControllers[index],
                              decoration: InputDecoration(
                                labelText: "Non-terminal",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _productionControllers[index],
                              decoration: InputDecoration(
                                labelText: "Production",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blueAccent),
                                ),
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
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _nonTerminalControllers.add(TextEditingController());
                          _productionControllers.add(TextEditingController());
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text("Add Rule"),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _grammar = Grammar();

                  for (int i = 0; i < _nonTerminalControllers.length; i++) {
                    String nonTerminal = _nonTerminalControllers[i].text.trim();
                    String production = _productionControllers[i].text.trim();

                    if (nonTerminal.isNotEmpty && production.isNotEmpty) {
                      _grammar.addRule(nonTerminal, production);
                    }
                  }

                  if (_grammar.rules.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OutputScreen(grammar: _grammar),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please add at least one valid rule!')),
                    );
                  }
                },
                icon: Icon(Icons.check), // Check icon
                label: Text(" Generate"), // Label text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
