import 'package:firebase_test/navigator_pages/login_page.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String itemID;
  final String name;
  final String model;
  final int number;
  final String description;
  final int quantityLeft;
  final String price;
  final bool warrantyStatus;
  final String distributor;
  final String imageUrl;

  ItemCard(
      {required this.itemID,
      required this.name,
      required this.model,
      required this.number,
      required this.description,
      required this.quantityLeft,
      required this.price,
      required this.warrantyStatus,
      required this.distributor,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 80, 0),
                        child: Text(
                          "Item name: ${name}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.3),
                      Padding(
                        padding: const EdgeInsets.only(right: 80),
                        child: Text(
                          'Price: ${price}',
                          style: TextStyle(
                              fontSize: 18.0,
                              // ignore: deprecated_member_use
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 80, 0),
                        child: Text(
                          'Game Description: ${description}',
                          style: TextStyle(
                              fontSize: 18.0,
                              // ignore: deprecated_member_use
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 80, 0),
                        child: Text(
                          'Release Date: ${model}',
                          style: TextStyle(
                              fontSize: 18.0,
                              // ignore: deprecated_member_use
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                children: [
                  ElevatedButton(
                    child: const Text('Add Item'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(
                                //productId: productId,
                                ),
                          ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
