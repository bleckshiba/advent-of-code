import 'common.dart';

extension StringExt on String {
  String get firstHalf => this.substring(0, this.length ~/ 2);
  String get secondHalf => this.substring(this.length ~/ 2);
}

void main() async {
  Stream<String> lines = getLines('input.txt');

  int total = 0;
  await for (String line in lines) {
    Set<String> repeating = Set();
    List<String> chars = line.firstHalf.split('');
    for (String char in chars) {
      if (line.secondHalf.contains(char)) repeating.add(char);
    }
    total += getTotalPriorities(repeating);
  }

  print(total);
}
