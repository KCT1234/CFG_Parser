import 'grammar.dart';
import 'parse_tree.dart';

class CFGParser {
  Grammar grammar;
  int maxDepth;

  CFGParser(this.grammar, {this.maxDepth = 5});

  // Method 1: Generate possible strings
  Set<String> generateStrings(String symbol, [int depth = 0]) {
    if (depth > maxDepth) {
      return {};
    }

    Set<String> results = {};
    List<String>? productions = grammar.getProductions(symbol);

    if (productions != null) {
      for (var production in productions) {
        if (production.isEmpty) {
          results.add("");  // Epsilon production
        } else {
          Set<String> subResults = {""};
          for (var part in production.split('')) {
            if (RegExp(r'[A-Z]').hasMatch(part)) {
              Set<String> nextResults = generateStrings(part, depth + 1);
              Set<String> newSubResults = {};
              for (var prefix in subResults) {
                for (var suffix in nextResults) {
                  newSubResults.add(prefix + suffix);
                }
              }
              subResults = newSubResults;
            } else {
              subResults = subResults.map((prefix) => prefix + part).toSet();
            }
          }
          results.addAll(subResults);
        }
      }
    }

    return results.where((result) => result.length <= maxDepth + 5).toSet();
  }

  // Method to generate structured parse tree rows for the table view
  List<ParseTreeRow> generateParseTreeRows(String input) {
    return _buildParseTreeRows('S', input, input, 0);
  }

  List<ParseTreeRow> _buildParseTreeRows(String symbol, String target, String current, int depth) {
    List<ParseTreeRow> rows = [];

    if (depth > maxDepth || current.isEmpty) {
      return rows;
    }

    List<String>? productions = grammar.getProductions(symbol);
    if (productions == null || productions.isEmpty) {
      return rows;
    }

    for (var production in productions) {
      String result = current;
      String rule = '$symbol -> $production';
      String application = '';

      // Attempt to apply the production to the current string
      bool match = true;
      int index = 0;

      for (var part in production.split('')) {
        if (index >= current.length) {
          match = false;
          break;
        }

        if (RegExp(r'[A-Z]').hasMatch(part)) {
          // Non-terminal: recursively apply the rule
          List<ParseTreeRow> subRows = _buildParseTreeRows(part, target, current.substring(index), depth + 1);
          rows.addAll(subRows);
          if (subRows.isEmpty) {
            match = false;
            break;
          }
        } else if (part == current[index]) {
          // Terminal: match with current string
          application += part;
          index++;
        } else {
          // No match found, break
          match = false;
          break;
        }
      }

      if (match && result == target) {
        // Only add row if the result matches the target and no duplicate rule
        rows.add(ParseTreeRow(rule: rule, application: application, result: result));
        break; // Stop once we have a match
      }
    }

    return rows;
  }
}
