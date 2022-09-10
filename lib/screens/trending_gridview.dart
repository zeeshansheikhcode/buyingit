/**
 * This file contain Trending Products GridView
 */
import 'package:buying_final/model_provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import 'trending_detailscreen.dart';
class TrendingProducts extends StatefulWidget {
  const TrendingProducts({ Key? key }) : super(key: key);

  @override
  State<TrendingProducts> createState() => _TrendingProductsState();
}

class _TrendingProductsState extends State<TrendingProducts> {
  //A Screen to show Trending Items
   List<Product> itemlist =[];
  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);
     itemlist = prod.trendingItems;
           return GridView.builder(
            padding: const EdgeInsets.all(10),
             shrinkWrap: true,
             physics:const NeverScrollableScrollPhysics(),
             gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisExtent: 175,
              crossAxisSpacing: 10,
               ),
             itemCount:itemlist.length,
             itemBuilder: (context,index)
             {       
                 return  Container(
                 margin: const EdgeInsets.symmetric(vertical: 5),
                 child: ClipRRect(
                 borderRadius: BorderRadius.circular(15),
                 child: GridTile(
                 child:  GestureDetector(     
                 onTap: (){
              Navigator.of(context).
              pushNamed(
              TrendingDetailScreen.routeName ,
                 arguments: itemlist[index].id);
            },
            child: Hero(
              tag: itemlist[index].id,
              child: FadeInImage(
                  placeholder:const AssetImage('assets/images/product-placeholder.png'),
                  image: NetworkImage(itemlist[index].productImage),
                  fit:BoxFit.cover,
                  ),
              ),
            ),
         footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
         itemlist[index].title,
          textAlign: TextAlign.left,
          ),
          trailing: IconButton
          (
           onPressed: (){  
             cart.addItem(
                  itemlist[index].id, 
                  itemlist[index].price,
                  itemlist[index].title
                  );      
            //  Scaffold.of(context).hideCurrentSnackBar();
            //  Scaffold.of(context).showSnackBar(
            //    const  SnackBar(content:  Text('Added Item to Cart'),
            //      duration:  Duration(seconds: 2),
            //     //  action: SnackBarAction(label: 'UNDO', 
            //     //  onPressed: (){
            //     //     }),
            //      )
            //  );
           },
           color: Theme.of(context).accentColor,
           icon:const Icon(Icons.shopping_cart,size: 20,)),
                  ),
                 ),
              ),
               );
             }       
           );
    
  }
}