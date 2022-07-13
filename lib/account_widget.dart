import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_test/style_elements/text_field.dart';
import '/app_icon.dart';
import 'style_elements/dimensions.dart';

// ignore: must_be_immutable
class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(
            width: Dimensions.width20,
          ),
          bigText
        ],
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 1,
          offset: Offset(0, 2),
          color: Color.fromARGB(255, 193, 193, 193).withOpacity(0.2),
        )
      ]),
    );
  }
}
