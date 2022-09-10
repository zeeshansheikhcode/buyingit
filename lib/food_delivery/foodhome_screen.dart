/**
 * This File is a home screen of  Food Delivery
 */
import 'package:buying_final/food_delivery/pizza.dart';
import 'package:buying_final/food_delivery/sandwich.dart';
import 'package:buying_final/food_delivery/shawarma.dart';
import 'package:buying_final/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../screens/trending_detailscreen.dart';
import '../widget/drawer_screen.dart';
import '../widget/widget_appbar.dart';
import 'burger.dart';
class FoodHomeScreen extends StatefulWidget {
  const FoodHomeScreen({ Key? key }) : super(key: key);

  @override
  State<FoodHomeScreen> createState() => _FoodHomeScreenState();
}

class _FoodHomeScreenState extends State<FoodHomeScreen> {
  
  @override
  Widget build(BuildContext context) {
     final products = Provider.of<Products>(context,listen:false);
     final cart = Provider.of<Cart>(context,listen: false);
     List<Product> _allitems = products.items + products.trendingItems;
     List<Product> _selecteditems =[];
    for(int i=0;i<_allitems.length;i++)
    {
        if(
              _allitems[i].category == 'Pizza'  || _allitems[i].category == 'Sandwich'
           || _allitems[i].category == 'Burger' || _allitems[i].category == 'Shawarma'
           || _allitems[i].category == 'Trending Pizza'  || _allitems[i].category == 'Trending Sandwich'
           || _allitems[i].category == 'Trending Burger' || _allitems[i].category == 'Trending Shawarma'
          )
        {
          _selecteditems.add(_allitems[i]);
        }
    }
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppbar(context),
       drawer: const DrawerScreen(),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>
           [
            Card(
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.01,
                horizontal: constraint.minWidth*0.02
              ),
              color: Colors.white,
              elevation: 4,
              child: Column(
                children: <Widget>
                [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [ 
                     // SizedBox(width: constraint.maxWidth*0.05),
                      Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const ShawarmaScreen()));
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.03 ,
                              vertical:   constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:   constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                               height:  constraint.maxHeight * 0.08,
                                width:  constraint.maxWidth*0.4,
                            child:const Text('Shawarma',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
                            ),
                            decoration:const BoxDecoration(
                           color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                       Card(
                         child: InkWell(
                           onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const BurgerScreen()));
                          },
                           child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.025 ,
                              vertical: constraint.maxHeight*0.02 ,   
                              ),
                             padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                           height: constraint.maxHeight * 0.08,
                            width: constraint.maxWidth*0.4,
                            child:const Text('Burger',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
                            ),
                            decoration:const BoxDecoration(
                            color: Colors.white,
                            ),
                           ),
                         ),
                       ),
                    ],
                   ),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>
                    [  //const SizedBox(width: 20,),
                      Card(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const PizzaScreen()));
                          },
                          child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.033 ,
                              vertical:   constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.05,
                            ),
                            height:
                               constraint.maxHeight * 0.08,
                                width: constraint.maxWidth*0.4,
                            child:const Text('Pizza',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
                            ),
                            decoration:const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                       Card(
                         child: InkWell(
                           onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (_)=> const SandwichScreen()));
                          },
                           child: Container(
                            margin:  EdgeInsets.symmetric(
                              horizontal: constraint.maxWidth*0.022 ,
                              vertical: constraint.maxHeight*0.02 ,   
                              ),
                            padding: EdgeInsets.symmetric(
                              vertical:  constraint.maxHeight*0.015,
                              horizontal: constraint.minWidth*0.045,
                            ),
                            height:constraint.maxHeight * 0.08,
                                width: constraint.maxWidth*0.4,
                            child:const Text('Sandwich',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                               ),
                            ),
                            decoration:const BoxDecoration(
                              color: Colors.white,
                            ),
                           ),
                         ),
                       ),
                    ],
                   ),
                ],
              ),
            ),
             SizedBox(height: constraint.maxHeight*0.01,),
                GridView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
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
                   if(
                    _selecteditems[index].category == 'Trending Pizza' 
                 || _selecteditems[index].category == 'Trending Sandwich'
                 || _selecteditems[index].category == 'Trending Burger'
                 || _selecteditems[index].category == 'Trending Shawarma'
                     )
                        {
                            print('oo');
                            Navigator.of(context).
                            pushNamed(
                            TrendingDetailScreen.routeName ,
                            arguments: _selecteditems[index].id);
                        }
                        else
                        {   
                            print('11');
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
              //  Scaffold.of(context).hideCurrentSnackBar();
              //  Scaffold.of(context).showSnackBar(
              //   const   SnackBar(content: Text('Added Item to Cart'),
              //      duration:  Duration(seconds: 2),
        
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
           ],
         ),
       ),
    );
    });    
  }
}