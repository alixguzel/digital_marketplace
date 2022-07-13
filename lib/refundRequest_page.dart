import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/games.dart';
import 'package:firebase_test/history_page.dart';
import 'package:firebase_test/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'navigator_pages/login_page.dart';

class RefundSplashScreen extends StatelessWidget {
  const RefundSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/refundSplash.json"),
      // CHANGE THE NEXT SCREEN TO ORDER HISTORY PAGE
      nextScreen: const OrderHistoryPage(),
      splashIconSize: 2500,
      duration: 1200,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class RefundPage extends StatefulWidget {
  @override
  _RefundPageState createState() => _RefundPageState();
}

class _RefundPageState extends State<RefundPage> {
  // contacts -> orderHistorySublist

  List<historyGame> selectedGames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refund Page"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: orderHistorySublist.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return GameItem(
                        orderHistorySublist[index].name,
                        orderHistorySublist[index].amount,
                        orderHistorySublist[index].price,
                        orderHistorySublist[index].date,
                        index,
                        orderHistorySublist[index].isSelected,
                      );
                    }),
              ),
              selectedGames.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Color.fromARGB(255, 113, 65, 148),
                          child: Text(
                            "Request Refund (${selectedGames.length})",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            var rng = new Random();
                            var RID = rng.nextInt(1000000);

                            for (var product in selectedGames) {
                              _addtorefund(product, RID);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RefundSplashScreen()));
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget GameItem(String name, int amount, double price, String date, index,
      bool isSelected) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(name),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Color.fromARGB(255, 113, 65, 148),
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          orderHistorySublist[index].isSelected =
              !orderHistorySublist[index].isSelected;
          if (orderHistorySublist[index].isSelected == true) {
            selectedGames.add(orderHistorySublist[index]);
          } else if (orderHistorySublist[index].isSelected == false) {
            selectedGames.removeWhere(
                (element) => element.name == orderHistorySublist[index].name);
          }
        });
      },
    );
  }
}

void _addtorefund(historyGame refundProduct, int requestID) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();

  int gameid = 0;

  for (var game in gamelist) {
    if (game.name == refundProduct.name) {
      gameid = game.id;
    }
  }

  ref
      .child('refund')
      .child(userLogin.userID.toString())
      .child(requestID.toString())
      .child(gameid.toString())
      .child("amount")
      .set(refundProduct.amount);
  ref
      .child('refund')
      .child(userLogin.userID.toString())
      .child(requestID.toString())
      .child(gameid.toString())
      .child("name")
      .set(refundProduct.name);

  ref
      .child('refund')
      .child(userLogin.userID.toString())
      .child(requestID.toString())
      .child(gameid.toString())
      .child("price")
      .set(refundProduct.price.toString());

  ref
      .child('refund')
      .child(userLogin.userID.toString())
      .child(requestID.toString())
      .child(gameid.toString())
      .child("date")
      .set(refundProduct.date);
}
