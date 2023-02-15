import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() async {
  List<int> caloriesCarriedByElves = [];

  final input = File('input.txt');
  Stream<String> lines =
      input.openRead().transform(utf8.decoder).transform(LineSplitter());

  try {
    int caloriesCarried = 0;
    await for (var line in lines) {
      int? calories = int.tryParse(line);
      if (calories == null) {
        caloriesCarriedByElves.add(caloriesCarried);
        caloriesCarried = 0;
      } else {
        caloriesCarried += calories;
      }
    }
  } catch (e) {
    print(e);
  }

  // find the elf carried the most calories
  print(caloriesCarriedByElves.reduce((max)));

  // sort to get the ranking
  caloriesCarriedByElves.sort();

  print(caloriesCarriedByElves
      // find the top 3 elves carried the most calories
      .sublist(caloriesCarriedByElves.length - 3)
      // calculate the sum
      .reduce(sum));
}

int sum(int a, int b) => a + b;
