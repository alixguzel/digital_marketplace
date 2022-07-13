import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/navigator_pages/navigator.dart';
import 'package:digital_marketplace/responsive_login/login_mobile_body.dart';
import 'package:lottie/lottie.dart';
import 'navigator_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'games.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class WishlistSplashScreen extends StatelessWidget {
  const WishlistSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/wishlist_splash.json"),
      nextScreen: const WishList(),
      splashIconSize: 10000,
      duration: 2000,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final ref = WishList.database.ref();

  // ignore: non_constant_identifier_names
  Widget _PrintWishlist(List<Game> wishlist) {
    return ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              wishlist[index].name,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        title: Text("Your Wishlist"),
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigator()),
          );
        }),
      ),
      body: Column(
        children: [
          Expanded(child: _PrintWishlist(wishlist)),
        ],
      ),
    );
  }
}

List<Game> cart = List.empty(growable: true);


// double _totalprice() {
//   double sum = 0.0;
//   for (var i = 0; i < cart.length; i++) {
//     sum += cart[i].price;
//   }
//   return sum;
// }

// void donetransaction(List<Game> cart) {
//   for (var i = 0; i < demogames.length; i++) {
//     for (var j = 0; j < cart.length; j++) {
//       if (cart[j] == demogames[i]) {
//         demogames[i].stockamount--;
//       }
//     }
//   }

//   cart.clear();
// }

// void donetransactionFirebase() async {
//   FirebaseDatabase database = FirebaseDatabase.instance;
//   final ref = database.ref();
//   final snapshot = await ref.child('users').get();
//   ref
//       .child('users')
//       .child(userLogin.userID.toString())
//       .child('cart_gameIDs')
//       .remove();
// }
