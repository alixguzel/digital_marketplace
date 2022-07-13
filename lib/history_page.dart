import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/account_page.dart';
import 'package:firebase_test/cart.dart';
import 'package:firebase_test/navigator_pages/navigator.dart';
import 'package:firebase_test/refundRequest_page.dart';
import 'package:firebase_test/responsive_login/login_mobile_body.dart';
import 'package:lottie/lottie.dart';
import 'navigator_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'games.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<historyGame> orderHistorySublist = [];

class OrderHistoryPageSplashScreen extends StatelessWidget {
  const OrderHistoryPageSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/animated_splash.json"),
      nextScreen: const OrderHistoryPage(),
      splashIconSize: 10000,
      duration: 2000,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final ref = OrderHistoryPage.database.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        title: Text("Order History"),
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigator()),
          );
        }),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  itemCount: orderHistoryList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          orderHistorySublist = [];
                          for (var orderedGame in orderHistoryList[index]) {
                            orderHistorySublist.add(orderedGame);
                          }
                          for (var subOrderedGame in orderHistorySublist) {
                            print(subOrderedGame.name);
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RefundPage())); // TODO: Change page to product page
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            //border: Border.all(color: Color.fromARGB(255, 230, 230, 230)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                orderHistoryList[index][0].date,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 7),
                              ListView.builder(
                                  itemCount: orderHistoryList[index].length,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int subIndex) {
                                    return Text(
                                      "Name: " +
                                          orderHistoryList[index][subIndex]
                                              .name
                                              .toString() +
                                          '\n' +
                                          "Price: " +
                                          orderHistoryList[index][subIndex]
                                              .price
                                              .toString() +
                                          '\$' +
                                          '\n' +
                                          "Amount: " +
                                          orderHistoryList[index][subIndex]
                                              .amount
                                              .toString() +
                                          '\n',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          height: 1.2),
                                    );
                                  }),
                            ],
                          ),
                        ));
                  })),
        ],
      ),
    );
  }
}

List<Game> cart = List.empty(growable: true);
