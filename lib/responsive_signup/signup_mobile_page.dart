import 'package:digital_marketplace/navigator_pages/login_page.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:digital_marketplace/style_elements/input_field.dart';
import 'package:digital_marketplace/style_elements/text_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

class User {
  String email;
  String password;
  String password2;
  String name;
  String surname;
  User(this.email, this.password, this.password2, this.name, this.surname);
}

class SignupPageMobile extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;
  User user = User('', '', '', '', '');

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final ref = database.reference();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Expanded(
          child: Container(
            color: Color.fromARGB(255, 113, 65, 148),
            child: Center(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: "Sign-Up For Free!",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RoundedInputField(
                      hintText: "Your Name",
                      onChanged: (value) {
                        user.name = value;
                      },
                    ),
                    RoundedInputField(
                      hintText: "Your Surname",
                      onChanged: (value) {
                        user.surname = value;
                      },
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        user.email = value;
                      },
                    ),
                    PasswordField(
                      hintText: "Your Password",
                      onChanged: (value) {
                        user.password = value;
                      },
                    ),
                    PasswordField(
                      hintText: "Your Password Again",
                      onChanged: (value) {
                        user.password2 = value;
                      },
                    ),
                    ElevatedButton(
                        child: Text("SIGNUP"),
                        onPressed: () {
                          var rng = new Random();
                          var uid = rng.nextInt(1000000);
                          String fullname = user.name + " " + user.surname;
                          if (user.email != '' &&
                              user.name != '' &&
                              user.surname != '' &&
                              user.email != '' &&
                              user.password != '' &&
                              user.password2 != "" &&
                              user.password == user.password2) {
                            ref
                                .child('users')
                                .child(uid.toString())
                                .child('name')
                                .set(fullname);
                            ref
                                .child('users')
                                .child(uid.toString())
                                .child('password')
                                .set(user.password);
                            print(user.email);
                            ref
                                .child('users')
                                .child(uid.toString())
                                .child('email')
                                .set(user.email);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
