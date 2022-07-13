import 'package:firebase_database/firebase_database.dart';
import 'package:digital_marketplace/account_page.dart';
import 'package:digital_marketplace/main.dart';
import 'package:digital_marketplace/navigator_pages/navigator.dart';
import 'package:flutter/material.dart';

import '../style_elements/input_field.dart';

List<String> Categories = categorylist;
String categoryToAdd = " ";

class ManageCategories extends StatelessWidget {
  const ManageCategories({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Categories"),
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainNavigator()),
          );
        }),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
                height: 200.0,
                child: new ListView.builder(
                    itemCount: Categories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(Categories[index]),
                          ],
                        ),
                        trailing: TextButton(
                            onPressed: () {
                              deleteCategoryFirebase(Categories[index]);
                              Categories.remove(Categories[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManageCategories()));
                            },
                            child: Text("Remove")),
                      );
                    })),
          ),
          Row(
            children: <Widget>[
              RoundedInputField(
                icon: Icons.category,
                hintText: "Category to add",
                onChanged: (value) {
                  categoryToAdd = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    addCategoryFirebase(categoryToAdd);
                    Categories.add(categoryToAdd);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageCategories()));
                  },
                  child: Text("Add"))
            ],
          ),
        ],
      ),
    );
  }
}

void deleteCategoryFirebase(String deleteThis) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();

  ref.child('categories').child(deleteThis).remove();
}

void addCategoryFirebase(String addThis) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ref = database.ref();

  ref.child('categories').child(addThis).set("");
}
