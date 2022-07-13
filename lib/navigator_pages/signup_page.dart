import 'package:flutter/material.dart';
import '../style_elements/responsive_layout.dart';
import '../responsive_signup/signup_desktop_body.dart';
import '../responsive_signup/signup_mobile_page.dart';

class SignupPageMain extends StatelessWidget {
  late String pass_again;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: SignupPageMobile(),
        desktopBody: SignupPageDesktop(),
      ),
    );
  }
}
