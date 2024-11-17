import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{

  late String id;
  late String title;
  late String description;
  late double price;
  late List images;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.id;
    title = snapshot["title"];
    description = snapshot["description"];
    title = snapshot["title"];
    price = snapshot["price"] + 0.0;
    images = snapshot["images"];
  }

}