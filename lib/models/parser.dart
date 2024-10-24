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
}
