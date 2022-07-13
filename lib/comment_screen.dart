import 'package:flutter/material.dart';
import 'dummycomments.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class CommentRating {
  String comment, rate;
  CommentRating({required this.comment, required this.rate});
}

class _CommentScreenState extends State<CommentScreen> {
  Widget _buildCommentlist() {
    return ListView.builder(
        itemCount: dummycomments.length,
        itemBuilder: (context, index) {
          final CommentModel cmt = dummycomments[index];
          return ListTile(
              title: Text(dummycomments[index].user.name +
                  ' ' +
                  dummycomments[index].user.surname),
              subtitle: Text(dummycomments[index].comment),
              trailing: Text("Rating: " + dummycomments[index].rating));
        });
  }

  void _addCommentitem(CommentRating com) {
    dummyUser admin = dummyUser(name: "Admin", surname: "ADMIN");
    CommentModel temp = CommentModel(
        user: admin, comment: com.comment, time: time, rating: com.rate);
    setState(() {
      dummycomments.add(temp);
    });
  }

  CommentRating comrate = CommentRating(comment: " ", rate: " ");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 113, 65, 148),
            title: const Text("Reviews")),
        body: Column(children: [
          Expanded(child: _buildCommentlist()),
          TextField(
              onChanged: (String val) => comrate.comment = val,
              decoration: const InputDecoration(hintText: "Add a comment")),
          TextField(
              onChanged: (String val) => comrate.rate = val,
              decoration: const InputDecoration(hintText: "Add a rating")),
          FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 113, 65, 148),
              tooltip: "Submit Review",
              onPressed: () => _addCommentitem(comrate))
        ]));
  }
}
