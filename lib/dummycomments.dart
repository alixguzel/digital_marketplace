import 'package:intl/intl.dart';

// ignore: camel_case_types
class dummyUser {
  int id;
  String name;
  String surname;
  dummyUser({this.id = 0, required this.name, required this.surname});
}

dummyUser user1 = dummyUser(name: "Arsalan", surname: "Javeed");
dummyUser user2 = dummyUser(name: "Yahgra", surname: "Zen");
dummyUser user3 = dummyUser(name: "Aldmeri", surname: "Bip");
dummyUser user4 = dummyUser(name: "Bret", surname: "Cakarn");

const String time = "05/08/22";

class CommentModel {
  dummyUser user;
  String comment;
  String time;
  String rating;

  CommentModel(
      {required this.user,
      required this.comment,
      required this.time,
      required this.rating});
}

List<CommentModel> dummycomments = [
  CommentModel(
      user: user1,
      comment: "Wow, Such a great game!",
      time: time,
      rating: "5/5"),
  CommentModel(
      user: user2, comment: "The game is hard.", time: time, rating: "4.2/5"),
  CommentModel(
      user: user3, comment: "This game sucks!", time: time, rating: "2/5"),
  CommentModel(
      user: user4,
      comment: "I totally recommend it!",
      time: time,
      rating: "4.8/5")
];
