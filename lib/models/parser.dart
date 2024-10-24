import 'grammar.dart';

class CFGParser {
  Grammar grammar;
  int maxDepth;

  CFGParser(this.grammar, {this.maxDepth = 5});

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

    // Ensure unique results and vary string lengths by limiting duplicates
    return results.where((result) => result.length <= maxDepth + 5).toSet();
  }

  // New Method: Generate a simple parse tree string for the given input
  String generateParseTree(String input) {
    return _buildParseTree('S', input, 0);
  }

  String _buildParseTree(String symbol, String input, int depth) {
    if (depth > maxDepth) {
      return '';  // Limit recursion depth
    }

    List<String>? productions = grammar.getProductions(symbol);
    if (productions == null || productions.isEmpty) {
      return '$symbol -> (no production)\n';
    }

    for (var production in productions) {
      String result = '$symbol -> $production\n';

      int inputIndex = 0;
      for (var part in production.split('')) {
        if (inputIndex < input.length && part == input[inputIndex]) {
          inputIndex++;
          result += _buildParseTree(part, input, depth + 1);
        } else if (RegExp(r'[A-Z]').hasMatch(part)) {
          result += _buildParseTree(part, input, depth + 1);
        }
      }
      return result;  // Return the first match (simple tree)
    }

    return '';  // Fallback in case no match is found
  }
}
