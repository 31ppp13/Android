import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mercadinho_app/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: getData(),
        builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{

              return ListView(
                children: (snapshot.data as QuerySnapshot).docs.map(
                    (doc){
                      return CategoryTile(doc);
                    }
                ).toList(),
              );
            }
        },
    );
  }
}

Future<QuerySnapshot> getData() async {
  await Firebase.initializeApp();
  return await FirebaseFirestore.instance.collection("products").get();
}