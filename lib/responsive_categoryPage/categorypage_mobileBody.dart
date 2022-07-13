import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/navigator_pages/login_page.dart';
import 'package:digital_marketplace/main.dart';
import 'package:digital_marketplace/responsive_homepage/homepage_mobileBody.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:digital_marketplace/style_elements/dimensions.dart';
import 'package:digital_marketplace/pd_screen.dart';
import 'package:flutter/material.dart';
import '../../games.dart';
import '../../responsive_login/login_mobile_body.dart';

class MobileCategoryPage extends StatefulWidget {
  const MobileCategoryPage({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  State<MobileCategoryPage> createState() => _MobileCategoryPageState();
}

class _MobileCategoryPageState extends State<MobileCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentCategory),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categoryGameList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    int iterIndex = 0;
                    while (iterIndex < gamelist.length) {
                      if (gamelist[iterIndex].name ==
                          categoryGameList[index].name) {
                        break;
                      } else {
                        iterIndex += 1;
                      }
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                productId: gamelist[iterIndex]
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
                        categoryGameList[index].name,
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
              crossAxisCount: 2,
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
