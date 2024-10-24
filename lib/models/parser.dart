import 'grammar.dart';

class CFGParser {
  Grammar grammar;
  int maxDepth;

  CFGParser(this.grammar, {this.maxDepth = 10});

  List<String> generateStrings(String symbol, [int depth = 0]) {
    if (depth > maxDepth) {
      return [];
    }

    List<String> results = [];
    List<String>? productions = grammar.getProductions(symbol);

    if (productions != null) {
      for (var production in productions) {
        if (production.isEmpty) {
          results.add("");  // Epsilon production ('e')
        } else {
          List<String> subResults = [""];
          for (var part in production.split('')) {
            if (RegExp(r'[A-Z]').hasMatch(part)) {
              List<String> nextResults = generateStrings(part, depth + 1);
              subResults = [
                for (var prefix in subResults)
                  for (var suffix in nextResults) "$prefix$suffix"
              ];
            } else {
              subResults = [for (var prefix in subResults) "$prefix$part"];
            }
          }
          results.addAll(subResults);
        }
      }
    }
    return results;
  }
}
