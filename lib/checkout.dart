import 'dart:math';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'navigator_pages/login_page.dart';
import 'navigator_pages/navigator.dart';

class CheckoutSplashScreen extends StatelessWidget {
  const CheckoutSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    donetransactionFirebase();
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/postPayment_splash.json"),
      // CHANGE THE NEXT SCREEN TO ORDER HISTORY PAGE
      nextScreen: const MainNavigator(),
      splashIconSize: 2500,
      duration: 1200,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CheckoutPageState();
  }
}

class CheckoutPageState extends State<CheckoutPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 113, 65, 148),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: !useBackgroundImage
                ? const DecorationImage(
                    image: ExactAssetImage('assets/bg.png'),
                    fit: BoxFit.fill,
                  )
                : null,
            color: Colors.white,
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                CreditCardWidget(
                  glassmorphismConfig:
                      useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: Colors.red,
                  backgroundImage:
                      useBackgroundImage ? 'assets/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.black,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: border,
                            enabledBorder: border,
                            labelText: 'Card Holder',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: const Color(0xff1b447b),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            child: const Text(
                              'Validate',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('valid!');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CheckoutSplashScreen()),
                              );
                            } else {
                              print('invalid!');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

void donetransactionFirebase() async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();
  final snapshot = await ref.child('users').get();
  final snapshotGames = await ref.child('games').get();
  DateTime now = DateTime.now();
  var rng = new Random();
  var orderID = rng.nextInt(1000000);
  String formattedDate = DateFormat('dd/MM/yyyy – kk:mm').format(now);
  String keyDate = DateFormat('yyyyMMddkkmm').format(now);
  for (var g in snapshot
      .child(userLogin.userID.toString())
      .child('cart_gameIDs')
      .children) {
    ref
        .child('users')
        .child(userLogin.userID.toString())
        .child('order_history')
        .child(keyDate)
        .child(g.key.toString())
        .child("name")
        .set(g.child("name").value);

    ref
        .child('users')
        .child(userLogin.userID.toString())
        .child('order_history')
        .child(keyDate)
        .child(g.key.toString())
        .child("amount")
        .set(g.child("amount").value);

    ref
        .child('users')
        .child(userLogin.userID.toString())
        .child('order_history')
        .child(keyDate)
        .child(g.key.toString())
        .child("date")
        .set(formattedDate);

    ref
        .child('users')
        .child(userLogin.userID.toString())
        .child('order_history')
        .child(keyDate)
        .child(g.key.toString())
        .child("price")
        .set(g.child("price").value);

    for (var game in snapshotGames.children) {
      if (game.key.toString() == g.key.toString()) {
        int newStock = int.parse(game.child("stock").value.toString()) -
            int.parse(g.child("amount").value.toString());
        ref
            .child('games')
            .child(game.key.toString())
            .child("stock")
            .set(newStock);
      }
    }
  }
  ref
      .child('users')
      .child(userLogin.userID.toString())
      .child('cart_gameIDs')
      .remove();
}
