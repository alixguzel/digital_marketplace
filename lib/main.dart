import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/games.dart';
import 'package:digital_marketplace/navigator_pages/navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:lottie/lottie.dart';
import 'firebase_setup/firebase_config.dart';

List<Game> gamelist = [];
List<String> categorylist = [];
List<Game> categoryGameList = [];

final ref = SplashScreen.database.ref();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  runApp(MyApp());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  Future getbyidFirebase() async {
    final snapshot = await ref.child('games/').get();
    if (snapshot.exists) {
      List<Game> listgame = [];
      for (var m in snapshot.children.toList()) {
        Game new_game = Game(
          id: int.parse(m.key.toString()),
          stockamount: int.parse(m.child("stock").value.toString()),
          name: m.child("name").value.toString(),
          price: double.parse(m.child("price").value.toString()),
          categories: m.child("category").value.toString().split(","),
          description: m.child("description").value.toString(),
        );
        listgame.add(new_game);
      }
      gamelist = listgame;
    }
  }

  Future getbycategoryFirebase() async {
    final snapshot = await ref.child('categories/').get();
    if (snapshot.exists) {
      for (var m in snapshot.children.toList()) {
        categorylist.add(m.key.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getbyidFirebase();
    getbycategoryFirebase();
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/animated_splash.json"),
      nextScreen: const MainNavigator(),
      splashIconSize: 2500,
      duration: 4000,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G2B',
      /*routes: {
        '/': (BuildContext context) => SignupPage()
      },*/
      navigatorObservers: <NavigatorObserver>[observer],
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("You have an error! ${snapshot.error.toString()}");
            return Text("Something went wrong");
          } else if (snapshot.hasData) {
            return SplashScreen();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
