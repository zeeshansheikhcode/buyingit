/**
 * This File contains all Pizza Products
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../screens/detail_screen.dart';
import '../screens/trending_detailscreen.dart';
import '../widget/widget_appbar.dart';
class PizzaScreen extends StatefulWidget {
  const PizzaScreen({ Key? key }) : super(key: key);
  @override
  _PizzaScreenState createState() => _PizzaScreenState();
}

class _PizzaScreenState extends State<PizzaScreen> {
 
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); 
    final products = Provider.of<Products>(context,listen:false);
    final cart = Provider.of<Cart>(context,listen: false);
    List<Product> _allitems = products.items + products.trendingItems;
     List<Product> _selecteditems =[];
   // List<Product> _selecteditems =[];
    for(int i=0;i<_allitems.length;i++)
    {
        if(_allitems[i].category == 'Pizza' || _allitems[i].category == 'Trending Pizza')
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
                   if(_selecteditems[index].category == 'Trending Burger')
                        {
                            Navigator.of(context).
                            pushNamed(
                            TrendingDetailScreen.routeName ,
                            arguments: _selecteditems[index].id);
                        }
                        else
                        {
                            Navigator.of(context).
                            pushNamed(
                            DetailScreen.routeName ,
                            arguments: _selecteditems[index].id );
                        }
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
                   
                     
                   Toast.show('Item Added', duration: 2, gravity:Toast.bottom);  
              //  Scaffold.of(context).hideCurrentSnackBar();
              //  Scaffold.of(context).showSnackBar(
              //      SnackBar(content: const Text('Added Item to Cart'),
              //      duration: const Duration(seconds: 2),
              //      action: SnackBarAction(label: 'UNDO', 
              //      onPressed: (){
              //         }),
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
                        ),
             );
  }
}