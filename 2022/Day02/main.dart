import 'dart:convert';
import 'dart:io';

enum Shape {
  rock,
  paper,
  scissors,
}

extension ShapeExt on Shape {
  int get score {
    switch (this) {
      case Shape.rock:
        return 1;
      case Shape.paper:
        return 2;
      case Shape.scissors:
        return 3;
      default:
        return 0;
    }
  }

  int match(Shape shape) {
    if (this == Shape.rock) {
      if (shape == Shape.paper) return 0;
    } else if (this == Shape.paper) {
      if (shape == Shape.scissors) return 0;
    } else {
      if (shape == Shape.rock) return 0;
    }
    return 6;
  }
}

void main() async {
  Map<String, Shape> part1 = {
    'A': Shape.rock,
    'B': Shape.paper,
    'C': Shape.scissors,
    'X': Shape.rock,
    'Y': Shape.paper,
    'Z': Shape.scissors,
  };

  Map<String, Map<String, int>> part2 = {
    'A': {
      'X': 3,
      'Y': 4,
      'Z': 8,
    },
    'B': {
      'X': 1,
      'Y': 5,
      'Z': 9,
    },
    'C': {
      'X': 2,
      'Y': 6,
      'Z': 7,
    },
  };

  File input = File('./input.txt');
  Stream<String> lines =
      input.openRead().transform(utf8.decoder).transform(LineSplitter());

  int partOneScore = 0, partTwoScore = 0;
  // save pattern to lazy map, no need to compute everytime
  Map<String, int> partOnePattern = {};

  try {
    await for (String line in lines) {
      int scoreToAdd1 = 0, scoreToAdd2 = 0;
      List<String> match = line.split(" ");
      Shape opponent = part1[match[0]]!;
      Shape player = part1[match[1]]!;
      if (!partOnePattern.containsKey(line)) {
        if (opponent == player) {
          scoreToAdd1 = player.score + 3;
        } else {
          scoreToAdd1 = player.match(opponent) + player.score;
        }
        partOnePattern.putIfAbsent(line, () => scoreToAdd1);
      }
      // part 2
      scoreToAdd2 = part2[match[0]]![match[1]]!;

      partOneScore += partOnePattern[line]!;
      partTwoScore += scoreToAdd2;
    }
  } catch (e) {
    print(e);
  }
  print(partOneScore);
  print(partTwoScore);
}
