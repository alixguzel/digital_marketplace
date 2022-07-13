import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/cart.dart';
import 'package:digital_marketplace/comment_screen.dart';
import 'package:digital_marketplace/main.dart';
import 'package:digital_marketplace/navigator_pages/navigator.dart';
import 'package:digital_marketplace/responsive_login/login_mobile_body.dart';
import 'package:flutter/material.dart';
import '../games.dart';
import '../navigator_pages/login_page.dart';
import 'package:digital_marketplace/games.dart';
import '../navigator_pages/login_page.dart';
import '../pd_screen.dart';
import '../responsive_login/login_mobile_body.dart';
import '../style_elements/dimensions.dart';

class DesktopProductDetailScreen extends StatelessWidget {
  int productId;
  DesktopProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = getbyid(productId, gamelist);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Center(
          child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Row(
              children: [
                // First Column
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 500,
                        width: 500,
                        child: Hero(
                          tag: product.id,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: 520,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Chip(
                                    label: Text(
                                      "\$${product.price}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                      product.stockamount.toString() +
                                          " Left in stock.",
                                      style: TextStyle(fontSize: 16)),
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 520,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "${product.description}",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 300,
                        height: 30.0,
                        child: Expanded(
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 113, 65, 148),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 113, 65, 148),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Center(
                                  child: Text("Comments",
                                      textAlign: TextAlign.center)),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentScreen()),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Second Column
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Center(
                          child: Text(
                        "People also buy:",
                        style: GoogleFonts.secularOne(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
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
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(35.0))),
                                          )),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      demogames[index]
                                                          .image)))),
                                    ),
                                  )),
                                  Text(
                                    gamelist[index].name,
                                    style: GoogleFonts.kanit(
                                        color: Colors.black,
                                        fontSize: 18,
                                        //fontWeight: FontWeight.bold,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.8)),
                                  ),
                                ],
                              ));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {
              showAlertDialogWishlist(context, getbyid(productId, gamelist));
            },
            backgroundColor: Colors.red,
            mini: true,
            child: const Icon(Icons.favorite),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              showAlertDialogCart(context, getbyid(productId, gamelist));
            },
            backgroundColor: Colors.green,
            mini: true,
            child: const Icon(Icons.add_shopping_cart_rounded),
          )
        ]));
  }

  showAlertDialogCart(BuildContext context, Game addedgame) {
    // set up the button
    Widget okButton =
        TextButton(child: Text("OK"), onPressed: () => Navigator.pop(context));
    String message = " ";
    if (addedgame.stockamount > 0) {
      message = "Game successfully added to cart.";
      _addtocart(gamelist, productId);
      //put the appopriate variable name
    } else {
      message = "Game is out of stock, failed to add to cart.";
    }
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message, style: TextStyle(fontSize: 23)),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogWishlist(BuildContext context, Game addedgame) {
    // set up the button
    Widget okButton =
        TextButton(child: Text("OK"), onPressed: () => Navigator.pop(context));
    String message = " ";
    message = "Game successfully added to wishlist.";
    _addtoWishList(gamelist, productId); //put the appopriate variable name
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(message, style: TextStyle(fontSize: 23)),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

void _addtocart(List<Game> gamelist, int gameid) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();
  final snapshot = await ref.child('users').get();

  String amount;
  bool exists = false;

  if (userLogin.userID == '') {
    print("PRE SNAPSHOT");
    for (var k in (snapshot.child("tempUser").child('cart_gameIDs').children)) {
      print("AFTER SNAPSHOT");
      if (int.parse(k.key.toString()) == gameid) {
        amount = (snapshot
                .child("tempUser")
                .child('cart_gameIDs')
                .child(gameid.toString())
                .child("amount")
                .value)
            .toString();
        ref
            .child('users')
            .child("tempUser")
            .child('cart_gameIDs')
            .child(gameid.toString())
            .child("amount")
            .set(int.parse(amount) + 1);

        exists = true;
      }
    }
    if (exists == false) {
      ref
          .child('users')
          .child("tempUser")
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("amount")
          .set(1);
      ref
          .child('users')
          .child("tempUser")
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("name")
          .set(getbyid(gameid, gamelist).name);

      ref
          .child('users')
          .child("tempUser")
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("price")
          .set(getbyid(gameid, gamelist).price.toString());
    }
    tempCartExists = true;
  } else {
    for (var k in (snapshot
        .child(userLogin.userID.toString())
        .child('cart_gameIDs')
        .children)) {
      if (int.parse(k.key.toString()) == gameid) {
        amount = (snapshot
                .child(userLogin.userID.toString())
                .child('cart_gameIDs')
                .child(gameid.toString())
                .child("amount")
                .value)
            .toString();
        ref
            .child('users')
            .child(userLogin.userID.toString())
            .child('cart_gameIDs')
            .child(gameid.toString())
            .child("amount")
            .set(int.parse(amount) + 1);

        exists = true;
      }
    }
    if (exists == false) {
      ref
          .child('users')
          .child(userLogin.userID.toString())
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("amount")
          .set(1);
      ref
          .child('users')
          .child(userLogin.userID.toString())
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("name")
          .set(getbyid(gameid, gamelist).name);

      ref
          .child('users')
          .child(userLogin.userID.toString())
          .child('cart_gameIDs')
          .child(gameid.toString())
          .child("price")
          .set(getbyid(gameid, gamelist).price.toString());
    }
  }
}

void _addtoWishList(List<Game> gamelist, int gameid) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();
  final snapshot = await ref.get();

  ref
      .child('users')
      .child(userLogin.userID.toString())
      .child('wishList_gameIDs')
      .child(gameid.toString())
      .child("name")
      .set(
          snapshot.child("games").child(gameid.toString()).child("name").value);
}
