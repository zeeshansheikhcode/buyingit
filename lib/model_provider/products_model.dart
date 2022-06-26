/**
 * This File contain Product Model
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Product with ChangeNotifier
{
  //Attributes of Products
   String id;
   String title;
   double price;
   double quantity;
   String description;
   String productImage;
   String category; 
   String CreatorID;
   String seller;
  Product(
    {
     required this.id,
     required this.title,
     required this.price,
     required this.quantity,
     required this.description, 
     required this.productImage,
     required this.category,
     required this.CreatorID,
     required this.seller,
    });
    factory Product.fromDocument(QueryDocumentSnapshot doc) {
    return Product(
      id:           doc["id"],
      title:        doc["title"], 
      price:        doc["price"], 
      quantity:     doc["quantity"], 
      description:  doc["description"],
      category:     doc["category"], 
      productImage: doc["productImage"], 
      CreatorID:    doc["CreatorID"], 
     seller:        doc["seller"]
    );
  }
}
