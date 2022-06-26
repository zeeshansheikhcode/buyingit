/**
 * This File contain code of search Product Item List View
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/products.dart';
import '../screens/add_product.dart';
class SellerProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String productImage;
  const SellerProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productImage),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>
          [
            IconButton(onPressed: () {
              try{
                // await
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              }
              catch(error)
              {
               // scaffold.showSnackBar(SnackBar(content: const Text('Deletion Failed', textAlign: TextAlign.center,)));
              }
            
            }, icon: const Icon(Icons.delete),
            color:Theme.of(context).primaryColor,
            ),
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(AddProduct.routeName, arguments: id);
            }, icon: const Icon(Icons.edit),
            color:Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),      
    );
  }
}
