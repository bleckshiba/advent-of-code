import 'common.dart';

extension StringExt on String {
  String get firstHalf => this.substring(0, this.length ~/ 2);
  String get secondHalf => this.substring(this.length ~/ 2);
}

void main() async {
  Stream<String> lines = getLines('input.txt');

  int total = 0;
  List<String> contents = [];
  await for (String line in lines) {
    contents.add(line);
  }
  const size = 3;
  // List<List<String>> groups = List.generate(
  //     contents.length ~/ size,
  //     (i) =>
  //         [contents[size * i], contents[size * i + 1], contents[size * i + 2]]);

  List<List<String>> groups = [];
  for (int i = 0; i < contents.length; i += 3) {
    List<String> sub = [];
    for (int j = 0; j < size; j++) {
      sub.add(contents[i + j]);
    }
    groups.add(sub);
  }

  for (List<String> group in groups) {
    Set<String> repeating = Set();
    for (String char in group.elementAt(0).split('')) {
      if (group.elementAt(1).contains(char) &&
          group.elementAt(2).contains(char)) {
        repeating.add(char);
      }
    }

    total += getTotalPriorities(repeating);
  }

  print(total);
}
