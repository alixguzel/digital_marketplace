import 'package:firebase_database/firebase_database.dart';

class Game {
  final int id;
  int stockamount;
  final String name, description, image;
  final double popularity, price;
  final List<String> categories;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = Game.database.reference();

  Game(
      {required this.id,
      required this.stockamount,
      required this.name,
      required this.price,
      required this.categories,
      this.popularity = 0.0,
      this.description = " ",
      this.image = " "});

  /*
  Future<Game> getbyidFirebaseStock(int gameid, List<Game> gamelist) async {
    final snapshot = await ref.child('games/').get();
    if (snapshot.exists) {
      for (var m in snapshot.children) {
        if (m.value == gameid) {
          int iter = 0;
          for (var k in m.children) {
            iter += 1;
            if (iter == 2) {
              return (k);
            }
          }
        }
        return gamelist[0]; //fail
      }
    }
    return gamelist[0];
  }
  */
}

class cartGame {
  final int id;
  int amount;
  double price;
  final String name;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = Game.database.ref();

  cartGame({
    required this.id,
    required this.amount,
    required this.price,
    required this.name,
  });

  /*
  Future<Game> getbyidFirebaseStock(int gameid, List<Game> gamelist) async {
    final snapshot = await ref.child('games/').get();
    if (snapshot.exists) {
      for (var m in snapshot.children) {
        if (m.value == gameid) {
          int iter = 0;
          for (var k in m.children) {
            iter += 1;
            if (iter == 2) {
              return (k);
            }
          }
        }
        return gamelist[0]; //fail
      }
    }
    return gamelist[0];
  }
  */
}

class historyGame {
  int amount;
  double price;
  final String name;
  final String date;
  static FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = Game.database.ref();
  bool isSelected = false;

  historyGame({
    required this.amount,
    required this.price,
    required this.name,
    required this.date,
  });
}

Game getbyid(int gameid, List<Game> gamelist) {
  for (var i = 0; i < gamelist.length; i++) {
    if (gamelist[i].id == gameid) {
      return gamelist[i];
    }
  }
  return gamelist[0]; //fail
}

List<Game> demogames = [
  Game(
      id: 1,
      name: "Escape from Tarkov",
      stockamount: 5,
      price: 23.99,
      categories: ["Survival", "Military Simulation", "FPS"],
      description:
          "Escape from Tarkov is a multiplayer first-person shooter video game in development by Battlestate Games for Windows. A closed alpha test of the game was first made available to select users on 4 August 2016, followed by a closed beta which has been running since July 2017.",
      image: "lib/images/shturman.jpg"),
  Game(
      id: 2,
      stockamount: 3,
      name: "Battlefield 1",
      price: 35.0,
      categories: ["FPS", "Military", "AAA"],
      description:
          "Battlefield 1 is a first-person shooter game developed by DICE and published by Electronic Arts. It is the tenth installment in the Battlefield series and the first main entry in the series since Battlefield 4, and was released for Microsoft Windows, PlayStation 4 and Xbox One in October 2016.",
      image: "lib/images/bf1.jpg"),
  Game(
      id: 3,
      stockamount: 0,
      name: "Skyrim",
      price: 5.0,
      categories: ["Fantasy", "Medieval", "RPG"],
      description:
          "The Elder Scrolls V: Skyrim is an action role-playing video game developed by Bethesda Game Studios and published by Bethesda Softworks.",
      image: "lib/images/skyrim.jpg"),
  Game(
      id: 4,
      stockamount: 10,
      name: "Dark Souls III",
      price: 3.27,
      categories: ["Fantasy", "Medieval", "RPG"],
      description:
          "Dark Souls III is a 2016 action role-playing video game developed by FromSoftware and published by Bandai Namco Entertainment for PlayStation 4, Xbox One, and Microsoft Windows. It is the fourth overall entry of the Souls series and the final installment of the Dark Souls trilogy",
      image: "lib/images/ds3.jpg"),
  Game(
      id: 5,
      stockamount: 10,
      name: "Super Mario",
      price: 33.27,
      categories: ["Fantasy", "RPG"],
      description: "A",
      image: "lib/images/ds3.jpg")
];
