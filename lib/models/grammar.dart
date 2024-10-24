class Grammar {
  Map<String, List<String>> rules = {};

  Grammar();

  void addRule(String nonTerminal, String production) {
    if (!rules.containsKey(nonTerminal)) {
      rules[nonTerminal] = [];
    }
    // Split production by '|' and replace 'e' with epsilon (empty string)
    List<String> alternatives = production
        .split('|')
        .map((p) => p.trim() == 'e' ? '' : p.trim()) // Replace 'e' with empty string
        .toList();
    rules[nonTerminal]?.addAll(alternatives);
  }


  List<String>? getProductions(String nonTerminal) {
    return rules[nonTerminal];
  }
}
