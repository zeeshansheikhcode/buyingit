/**
 * This file contain Specific User Uploaded Products 
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/products.dart';
import '../widget/seller_productitem.dart';

class SellerProductScreen extends StatelessWidget {
  const SellerProductScreen({ Key? key }) : super(key: key);
  static const routeName = '/seller_product';
  //This Screen is used to get All User Products
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        leading: IconButton(onPressed:() { Navigator.pop(context);} , icon: const Icon(Icons.arrow_back),),
      ),
      
      body:
             Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  ListView.builder(
                    itemCount: productData.items.length,
                    itemBuilder: (_,i)=>Column(
                      children:
                      [
                        SellerProductItem(
                           id     : productData.items[i].id,
                         title    : productData.items[i].title,
                      productImage: productData.items[i].productImage,
                        ),
                        const Divider(),
                      ],
                     ),
                    ),
                 ),
          );
      
  }
}