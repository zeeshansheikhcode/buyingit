/**
 * This File contains all Shawarma Products
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../screens/detail_screen.dart';
import '../widget/widget_appbar.dart';
class ShawarmaScreen extends StatefulWidget {
  const ShawarmaScreen({ Key? key }) : super(key: key);
  @override
  _ShawarmaScreenState createState() => _ShawarmaScreenState();
}

class _ShawarmaScreenState extends State<ShawarmaScreen> {
 
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context,listen:false);
    final cart = Provider.of<Cart>(context,listen: false);
    List<Product> _allitems = products.items + products.trendingItems;
     List<Product> _selecteditems =[];
    for(int i=0;i<_allitems.length;i++)
    {
        if(_allitems[i].category == 'Shawarma')
        {
          _selecteditems.add(_allitems[i]);
        }
    }
    return  Scaffold(
                appBar:  CustomAppbar(context),
                body: _selecteditems.isEmpty
                 ?
                  const  Center(child: Text('No data'))
                 :
                GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisExtent: 175,
                crossAxisSpacing: 10,
                 ),
               itemCount:_selecteditems.length,
               itemBuilder: (context,index)
               {   
                   
                     return  Container(
                     margin: const EdgeInsets.symmetric(vertical: 5),
                     child: ClipRRect(
                     borderRadius:  BorderRadius.circular(15),
                     child: GridTile(
                   child:  GestureDetector(     
                   onTap: (){
                   Navigator.of(context).
                   pushNamed(
                   DetailScreen.routeName ,
                   arguments: _selecteditems[index].id );
                  },
                 child: Hero(
                 tag: _selecteditems[index].id,
                 child: FadeInImage(
                    placeholder:const AssetImage('assets/images/product-placeholder.png'),
                    image: NetworkImage(_selecteditems[index].productImage),
                    fit:BoxFit.cover,
                    ),
                ),
                         ),
                      footer: GridTileBar(
                       backgroundColor: Colors.black87,
                       title: Text(
                      _selecteditems[index].title,
                       textAlign: TextAlign.justify,
                       ),
                       trailing: IconButton
                       (
                        onPressed: (){  
               cart.addItem(
                    _selecteditems[index].id, 
                   _selecteditems[index].price,
                   _selecteditems[index].title);      
               Scaffold.of(context).hideCurrentSnackBar();
               Scaffold.of(context).showSnackBar(
                   SnackBar(content: const Text('Added Item to Cart'),
                   duration: const Duration(seconds: 2),
                   action: SnackBarAction(label: 'UNDO', 
                   onPressed: (){
                      }),
                   )
               );
                        },
                        color: Theme.of(context).accentColor,
                        icon:const Icon(Icons.shopping_cart,size: 20,)),
                    ),
                   ),
                ),
                 );
               }      
                        ),
             );
  }
}