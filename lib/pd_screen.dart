import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_test/cart.dart';
import 'package:firebase_test/comment_screen.dart';
import 'package:firebase_test/main.dart';
import 'package:firebase_test/navigator_pages/navigator.dart';
import 'package:firebase_test/responive_pdScreen/pdScreen_desktopBody.dart';
import 'package:firebase_test/responive_pdScreen/pdScreen_mobileBody.dart';
import 'package:firebase_test/responsive_login/login_mobile_body.dart';
import 'package:firebase_test/style_elements/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'games.dart';
import 'navigator_pages/login_page.dart';
import 'responsive_login/login_mobile_body.dart';

class ProductDetailScreen extends StatelessWidget {
  int productId;
  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = getbyid(productId, gamelist);

    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileProductDetailScreen(
          productId: productId,
        ),
        desktopBody: DesktopProductDetailScreen(
          productId: productId,
        ),
      ),
    );
  }
}
