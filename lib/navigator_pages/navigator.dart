import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/cart.dart';
import 'package:digital_marketplace/games.dart';
import 'package:digital_marketplace/navigator_pages/login_page.dart';
import 'package:digital_marketplace/wishlist.dart';
import 'package:flutter/material.dart';
//import 'package:g2b_demo/screens/login_page.dart';
import 'home_page.dart';
import '../../search_page.dart';
import '../../account_page.dart';
import '../responsive_login/login_mobile_body.dart';

bool tempNavigation = true;
bool tempCartExists = false;

List<cartGame> cartlist = [];
List<Game> wishlist = [];
List<List<historyGame>> orderHistoryList = [];

//Map<int, List<historyGame>> orderHistoryList = {};

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  final ref = MainNavigator.database.ref();
  int _selectedIndex = 0; // current index variable
  List<Widget> _screens = [
    // list of screens to be navigated
    //LoginPage(),
    HomePage(),
    SearchingPage(),
    AccountPage(),
  ];

  Future getbyidFirebaseCart() async {
    if (userLogin.userID == '') {
      final snapshot = await ref
          .child('users')
          .child("tempUser")
          .child('cart_gameIDs')
          .get();
      if (snapshot.exists) {
        List<cartGame> listgame = [];
        for (var m in snapshot.children.toList()) {
          cartGame new_game = cartGame(
            id: int.parse(m.key.toString()),
            amount: int.parse(m.child("amount").value.toString()),
            name: m.child("name").value.toString(),
            price: double.parse(m.child("price").value.toString()),
          );
          listgame.add(new_game);
        }
        cartlist = listgame;
      }
    } else {
      final snapshot = await ref
          .child('users')
          .child(userLogin.userID)
          .child('cart_gameIDs')
          .get();
      if (snapshot.exists) {
        List<cartGame> listgame = [];
        for (var m in snapshot.children.toList()) {
          cartGame new_game = cartGame(
            id: int.parse(m.key.toString()),
            amount: int.parse(m.child("amount").value.toString()),
            name: m.child("name").value.toString(),
            price: double.parse(m.child("price").value.toString()),
          );
          listgame.add(new_game);
        }
        cartlist = listgame;
      }
    }
  }

  Future getbyidFirebaseWishlist() async {
    final snapshot = await ref
        .child('users')
        .child(userLogin.userID)
        .child('wishList_gameIDs')
        .get();
    if (snapshot.exists) {
      List<Game> listgame = [];
      for (var m in snapshot.children.toList()) {
        Game new_game = Game(
          id: 9999,
          stockamount: 9999,
          name: m.child("name").value.toString(),
          price: 99.99,
          categories: [],
          description: "Dummy text",
        );
        listgame.add(new_game);
      }
      wishlist = listgame;
    }
  }

  Future getbyidFirebaseOrderHistory() async {
    final snapshot = await ref
        .child('users')
        .child(userLogin.userID)
        .child('order_history')
        .orderByKey()
        .get();
    if (snapshot.exists) {
      List<List<historyGame>> listGame = [];
      for (var m in snapshot.children.toList().reversed) {
        List<historyGame> subListGame = [];
        for (var k in m.children) {
          if (k != null) {
            historyGame new_game = historyGame(
              amount: int.parse(k.child("amount").value.toString()),
              name: k.child("name").value.toString(),
              price: double.parse(k.child("price").value.toString()),
              date: k.child("date").value.toString(),
            );
            subListGame.add(new_game);
          }
        }
        listGame.add(subListGame);
      }
      print("OUT OF THE LOOP");
      orderHistoryList = listGame;
    }
  }

  // Future getbyidFirebaseOrderHistory() async {
  //   final snapshot = await ref
  //       .child('users')
  //       .child(userLogin.userID)
  //       .child('order_history')
  //       .get();
  //   if (snapshot.exists) {
  //     List<historyGame> historyListGame = [];
  //     for (var m in snapshot.children) {
  //       for (var k in m.children.toList()) {
  //         historyGame new_game = historyGame(
  //           amount: int.parse(k.child("amount").value.toString()),
  //           name: k.child("name").value.toString(),
  //           price: double.parse(k.child("price").value.toString()),
  //           date: k.child("date").value.toString(),
  //         );
  //         historyListGame.add(new_game);
  //       }
  //       orderHistoryList[int.parse(m.key.toString())] = historyListGame;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 113, 65, 148),
        leading: IconButton(
          onPressed: () {
            //TODO: Remove comment after adding firebase.
            global_check = false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          icon: Icon(
            Icons.login,
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
        ),
        title: Center(
          child: Text("G2B"),
        ), // TODO: implement title changing as you navigate.
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO: Remove comment after implementing CartPage
              getbyidFirebaseWishlist();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WishlistSplashScreen()),
              );
            },
            alignment: Alignment.centerRight,
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO: Remove comment after implementing CartPage
              getbyidFirebaseCart();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CartSplashScreen()),
              );
            },
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // HOME
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            // SEARCH
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            // PROFILE
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
          getbyidFirebaseOrderHistory();
        },
        currentIndex: _selectedIndex,
      ),
    ));
  }
}
