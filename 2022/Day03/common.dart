import 'dart:convert';
import 'dart:io';

const String _alpha = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

Stream<String> getLines(String filename) {
  File input = File(filename);
  Stream<String> lines =
      input.openRead().transform(utf8.decoder).transform(LineSplitter());
  return lines;
}

int getTotalPriorities(Set<String> set) {
  int total = 0;

  set.forEach((element) {
    total += _alpha.indexOf(element) + 1;
  });
  return total;
}
