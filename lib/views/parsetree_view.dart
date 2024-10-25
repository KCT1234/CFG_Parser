import 'package:flutter/material.dart';
import 'package:atf_finals/models/parse_tree.dart';
import 'package:atf_finals/models/parser.dart';

class ParseTreeScreen extends StatelessWidget {
  final String string;
  final CFGParser parser;

  const ParseTreeScreen({super.key, required this.string, required this.parser});

  @override
  Widget build(BuildContext context) {
    List<ParseTreeRow> rows;

    try {
      rows = parser.generateParseTreeRows(string);
    } catch (e) {
      rows = [ParseTreeRow(rule: 'Error', application: 'Error', result: 'Error')];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Parse Tree for \"$string\""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Rule',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Application',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Result',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: rows.map((row) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(row.rule)),
                  DataCell(Text(row.application)),
                  DataCell(Text(row.result)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
