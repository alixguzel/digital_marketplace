import 'package:digital_marketplace/games.dart';
import 'package:digital_marketplace/main.dart';
import 'package:digital_marketplace/responsive_homepage/homepage_mobileBody.dart';
import 'package:digital_marketplace/responsive_homepage/homepage_desktopBody.dart';
import '../style_elements/responsive_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future getbyidFirebase() async {
      final snapshot = await ref.child('games/').get();
      if (snapshot.exists) {
        List<Game> listgame = [];
        for (var m in snapshot.children.toList()) {
          Game new_game = Game(
            id: int.parse(m.key.toString()),
            stockamount: int.parse(m.child("stock").value.toString()),
            name: m.child("name").value.toString(),
            price: double.parse(m.child("price").value.toString()),
            categories: m.child("category").value.toString().split(","),
            description: m.child("description").value.toString(),
          );
          listgame.add(new_game);
        }
        gamelist = listgame;
      }
    }

    getbyidFirebase();

    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileHomePage(),
        desktopBody: DesktopHomePage(),
      ),
    );
  }
}
