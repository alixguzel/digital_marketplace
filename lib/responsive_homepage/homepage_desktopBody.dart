import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/navigator_pages/login_page.dart';
import 'package:firebase_test/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_test/style_elements/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_test/games.dart';
import 'package:firebase_test/pd_screen.dart';

import '../navigator_pages/category_page.dart';
import 'homepage_mobileBody.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.height10,
          ),
          Container(
              height: 60,
              child: ListView.builder(
                  itemCount: categorylist.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          categoryGameList = [];
                          currentCategory = categorylist[index];
                          for (var game in gamelist) {
                            for (var category in game.categories) {
                              print(category.trim());
                              if (category.trim() == categorylist[index] &&
                                  categoryGameList.contains(game) == false) {
                                categoryGameList.add(game);
                              }
                            }
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage())); // TODO: Change page to product page
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 60,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                //border: Border.all(color: Color.fromARGB(255, 230, 230, 230)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: Center(
                                child: Text(
                                  categorylist[index],
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ));
                  })),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: gamelist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                productId: gamelist[index]
                                    .id))); // TODO: Change page to product page
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: Card(
                        borderOnForeground: false,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                              width: 900,
                              height: 900,
                              child: Center(
                                  child: Container(
                                width: 900,
                                height: 900,
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(35.0))),
                              )),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image:
                                          AssetImage(demogames[index].image)))),
                        ),
                      )),
                      Text(
                        gamelist[index].name,
                        style: GoogleFonts.kanit(
                            color: Colors.black,
                            fontSize: 18,
                            //fontWeight: FontWeight.bold,
                            backgroundColor: Colors.white.withOpacity(0.8)),
                      ),
                    ],
                  ));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
          ))
        ],
      ),
    );
  }
}

Container Feed() {
  return Container(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
    height: 200,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Container(
          width: 200,
          color: Colors.redAccent,
        ),
        Container(
          width: 200,
          color: Colors.orangeAccent,
        ),
        Container(
          width: 200,
          color: Colors.blueAccent,
        ),
        Container(
          width: 200,
          color: Colors.greenAccent,
        ),
        Container(
          width: 200,
          color: Colors.yellowAccent,
        ),
        Container(
          width: 200,
          color: Colors.lightGreenAccent,
        ),
      ],
    ),
  );
}
