import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/navigator_pages/navigator.dart';
import 'package:lottie/lottie.dart';
import 'checkout.dart';
import 'navigator_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'games.dart';
import 'package:intl/intl.dart';

class CartSplashScreen extends StatelessWidget {
  const CartSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/cart_splash.json"),
      nextScreen: const ShoppingCart(),
      splashIconSize: 2500,
      duration: 1200,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final ref = ShoppingCart.database.ref();

  // ignore: non_constant_identifier_names
  Widget _PrintCart(List<cartGame> cart) {
    return ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Text(
              cart[index].name,
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            subtitle: Text(
              "Price: " +
                  cart[index].price.toString() +
                  '\$' +
                  '\n' +
                  "Amount: " +
                  cart[index].amount.toString(),
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        title: Text("Your Cart"),
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigator()),
          );
        }),
      ),
      body: Column(
        children: [
          Expanded(child: _PrintCart(cartlist)),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Total Price: " + _totalprice().toStringAsFixed(2) + '\$',
                  style: TextStyle(fontSize: 25),
                )),
          )),
          Container(
              height: 70,
              width: 150,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.black,
                              )))),
                  onPressed: () {
                    if (userLogin.userID != "" && cartlist.isNotEmpty) {
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
                    } else if (userLogin.userID != "" && cartlist.isEmpty) {
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  child: Text('Checkout')))
        ],
      ),
    );
  }
}

List<Game> cart = List.empty(growable: true);

double _totalprice() {
  double sum = 0.0;
  for (var i = 0; i < cartlist.length; i++) {
    sum += (cartlist[i].price * cartlist[i].amount);
  }
  return sum;
}

void donetransaction(List<Game> cart) {
  for (var i = 0; i < demogames.length; i++) {
    for (var j = 0; j < cart.length; j++) {
      if (cart[j] == demogames[i]) {
        demogames[i].stockamount--;
      }
    }
  }

  cart.clear();
}
