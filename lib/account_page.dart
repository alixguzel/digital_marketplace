import 'package:firebase_test/dummycomments.dart';
import 'package:firebase_test/history_page.dart';
import 'package:firebase_test/productManager/productManager_page.dart';
import 'package:flutter/material.dart';
import '/account_widget.dart';
import 'style_elements/text_field.dart';
import '/app_icon.dart';
import 'style_elements/dimensions.dart';
import 'navigator_pages/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 113, 65, 148),
          title: BigText(
            text: "Profile",
            size: 24,
            color: Colors.white,
          ),
        ),
        body: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(children: [
              //Profile Icon
              AppIcon(
                  icon: Icons.person,
                  backgroundColor: Colors.blue,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height45 + Dimensions.height30,
                  size: Dimensions.height15 * 7),
              SizedBox(
                height: Dimensions.height20,
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    //Name
                    AccountWidget(
                      appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: Colors.blue,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5),
                      bigText: BigText(text: userLogin.name),
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    //Mail
                    AccountWidget(
                      appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: Colors.yellow,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5),
                      bigText: BigText(text: userLogin.email),
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    //User ID
                    AccountWidget(
                      appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: Colors.blueGrey,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10 * 5 / 2,
                          size: Dimensions.height10 * 5),
                      bigText: BigText(text: userLogin.userID),
                    ),
                    SizedBox(
                      height: Dimensions.height15,
                    ),
                    //Order History
                    Container(
                        height: 70,
                        width: 150,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.black,
                                        )))),
                            onPressed: () {
                              if (userLogin.userID != "") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderHistoryPage()),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              }
                            },
                            child: Text('Order History'))),

                    //PRODUCT MANAGER TEST
                    Container(
                        height: 70,
                        width: 180,
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                          color: Colors.black,
                                        )))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductManager()),
                              );
                            },
                            child: Text('PRODUCT MANAGER TEST'))),
                  ],
                )),
              ),
            ])));
  }
}
