// ignore_for_file: avoid_print

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/games.dart';

import '../responsive_login/login_desktop_body.dart';
import '../responsive_login/login_mobile_body.dart';
import '../style_elements/responsive_layout.dart';
import 'package:flutter/material.dart';

class User1 {
  String email;
  String name;
  String password;
  String userID;
  User1(this.email, this.name, this.password, this.userID);
}

final ref = LoginPage.database.ref();

User1 userLogin = User1('', '', '', '');

class LoginPage extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  Future<bool> _database() async {
    final snapshot = await ref.child('users/').get();
    if (snapshot.exists) {
      bool isBreak = false;
      for (var m in snapshot.children) {
        bool emailcheck = false;
        bool password = false;
        if (m.child("email").value == userLogin.email) {
          emailcheck = true;
          userLogin.name = m.child("name").value.toString();
          userLogin.userID = m.key.toString();
        }
        if (m.child("password").value == userLogin.password) {
          password = true;
        }
        if (emailcheck && password) {
          isBreak = true;
        }
      }
      return isBreak;
    } else {
      return false;
    }
  }

  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MyMobileBody(),
        desktopBody: MyDesktopBody(),
      ),
    );
  }
}
