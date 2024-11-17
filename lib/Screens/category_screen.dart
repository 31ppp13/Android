import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mercadinho_app/datas/product_data.dart';

import '../tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot["title"],
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 97, 176, 44),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: getData(snapshot),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return TabBarView(
                    children:[
                      GridView.builder(
                        padding: EdgeInsets.all(4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.65
                        ),
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index){
                          return ProductTile(ProductData.fromDocument((snapshot.data as QuerySnapshot).docs[index]));
                        }
                      )
                    ]
                  );
                }
              }
          )
        )
    );
  }
}

Future<QuerySnapshot> getData(DocumentSnapshot snapshot) async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance.collection("products").doc(snapshot.id)
  .collection("items").orderBy("pos").get();
}