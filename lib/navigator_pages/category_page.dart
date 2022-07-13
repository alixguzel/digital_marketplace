import 'package:firebase_test/games.dart';
import 'package:firebase_test/main.dart';
import 'package:firebase_test/responsive_homepage/homepage_mobileBody.dart';
import 'package:firebase_test/responsive_homepage/homepage_desktopBody.dart';
import '../responsive_categoryPage/categoryPage_desktopBody.dart';
import '../responsive_categoryPage/categorypage_mobileBody.dart';
import '../style_elements/responsive_layout.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileCategoryPage(),
        desktopBody: DesktopCategoryPage(),
      ),
    );
  }
}
