/**
 * This File Contain the Categories and Product GridView
 */
import 'package:buying_final/augmented_products/augmented_list.dart';
import 'package:buying_final/screens/trending_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../360images/threeDproducts.dart';
import '../CategoryScreens/fashion_screen.dart';
import '../CategoryScreens/hardware_screen.dart';
import '../CategoryScreens/home_appliance.dart';
import '../CategoryScreens/real_estate.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../widget/badge.dart';
import '../widget/drawer_screen.dart';
import '../widget/product_grid.dart';
import '../food_delivery/foodhome_screen.dart';
import 'cart_screen.dart';
class MenuHomeScreen extends StatefulWidget {
  const MenuHomeScreen({ Key? key }) : super(key: key);
  @override
  State<MenuHomeScreen> createState() => _MenuHomeScreenState();
}
class _MenuHomeScreenState extends State<MenuHomeScreen> {
  final storage1 = const FlutterSecureStorage(); // Collecting User ID
  List<Product> trending =[];                    // Trending Product List 
  @override
  Widget build(BuildContext context) {
  final prod = Provider.of<Products>(context); // Creating Products Provider Object
  trending = prod.items;                       //  Initializing Trending Products
    return LayoutBuilder(builder: (context,constriant) // Using Layout Builder For Responsiveness
    {
      return Scaffold(
      // Floating button for Showing Cart Quantity Number 
      floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
      onPressed: () {  
        //Navigate To Cart Screen
        Navigator.of(context).pushNamed(CartScreen.routeName); 
       },
       child : Consumer<Cart> // A provider Function which Update the cart quantity number
              (
                builder:(_,cart,ch)=>BBadge(
                color: Theme.of(_).accentColor,
                child: ch! ,
                value: cart.itemCount.toString(),
                 ),
                child: const  Icon(Icons.shopping_cart ,)  
                ),
      ),    
      backgroundColor: Colors.white,
      drawer: const DrawerScreen(), // Drawer showing various attributes
      body:   
         SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [     
              // Card To Show Title of Categories      
              Card(  
                margin:  EdgeInsets.symmetric(
                vertical: constriant.maxHeight*0.01,
                horizontal: constriant.maxWidth*0.02,
                ),
                color: Colors.white,
                elevation: 4,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=>const FoodHomeScreen() ));
                  },
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                        vertical: constriant.maxHeight*0.035,
                        horizontal: constriant.maxWidth*0.07,
                      ),
                      height: (
                                MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top ) * 0.04,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                         [  
                        const   Text('Fast Food',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                          // fontStyle: FontStyle.italic
                            ),
                           ),
                          SizedBox(width: constriant.maxWidth*0.2,),
                         const Icon(
                          Icons.restaurant,
                          color: Colors.black,
                          size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card To Show Title of Categories
              Card(
                margin: const EdgeInsets.only(
                  left :10,
                  right :10,
                  top :1,
                  bottom :1,),
                color: Colors.white,
                elevation: 4,
                child: Column(
                  children: <Widget>
                  [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>
                      [
                        Card( 
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const HomeAppliance()),
                              );
                            },
                            child: Container(
                              margin:  EdgeInsets.symmetric(
                                    vertical: constriant.maxHeight  * 0.01,
                                    horizontal: constriant.maxWidth * 0.005,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.003,
                                      ),
                              height:constriant.maxHeight * 0.1,
                                width: constriant.maxWidth*0.53,
                               child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:const  [
                                   Text('Home Appliance',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.tv, color: Colors.black,),
                                ],
                              ),
                              decoration:const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Card To Show Title of Categories
                         Card(
                           child: InkWell(
                             onTap: (){
                             Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const FashionScreen()),
                              );},
                             child: Container(
                               margin:  EdgeInsets.symmetric(
                                    vertical: constriant.maxHeight  * 0.01,
                                    horizontal: constriant.maxWidth * 0.005,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.01,
                                      ),
                             height:constriant.maxHeight * 0.1,
                              width: constriant.maxWidth*0.34,
                              child:Row(
                                children:const [
                                   Text('Fashion',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.sports_hockey,color: Colors.black,)
                                ],
                              ),
                              decoration:const BoxDecoration(
                               color: Colors.white,
                              ),
                             )
                           ),
                         )
                      ],
                     ),
                     Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>
                      [// Card To Show Title of Categories
                        Card(
                          child: InkWell(
                             onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const RealEstateScreen()),
                              );},
                            child: Container(
                                             margin:  EdgeInsets.only(
                                    left:   constriant.maxWidth * 0.06,
                                    right:  constriant.maxWidth * 0.01,
                                    top:    constriant.maxHeight  * 0.01,
                                    bottom: constriant.maxHeight  * 0.01,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.01,
                                      ),
                              height:constriant.maxHeight * 0.1,
                              width: constriant.maxWidth*0.4,
                              child:Row(
                                children: const [
                                  Text('Real Estate',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.home,color: Colors.black,)
                                ],
                              ),
                              decoration:const BoxDecoration(
                               color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Card To Show Title of Categories
                         Card(
                           child: InkWell(
                              onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_)=>const Hardware()),
                              );},
                             child: Container(
                                margin:  EdgeInsets.only(
                                    left:   constriant.maxWidth * 0.01,
                                    right:  constriant.maxWidth * 0.01,
                                    top:    constriant.maxHeight  * 0.01,
                                    bottom: constriant.maxHeight  * 0.01,
                              ),
                              padding:  EdgeInsets.symmetric(
                                        vertical: constriant.maxHeight * 0.01,
                                        horizontal: constriant.maxWidth* 0.03,
                                      ),
                               height: constriant.maxHeight * 0.1,
                               width: constriant.maxWidth  * 0.4,
                               child:Row(
                                children:const [
                                   Text('Hardware',
                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.black,
                                     ),
                                  ),
                                  Icon(Icons.hardware,color: Colors.black,)
                                ],
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
              // Card To Show Title of Categories
               Card(  
                margin:  EdgeInsets.symmetric(
                  vertical: constriant.maxHeight*0.005,
                  horizontal: constriant.maxWidth*0.02,
                  ),
                color: Colors.white,
                elevation: 4,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=>const ThreeDGrid() ));
                  },
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                        vertical: constriant.maxHeight*0.02,
                        horizontal: constriant.maxWidth*0.05,
                      ),
                      height: (
                                MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top ) * 0.07,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        const [  
                           Text('  360 View of Products',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                          // fontStyle: FontStyle.italic
                            ),
                           ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Card To Show Title of Categories
              Card(  
                margin:  EdgeInsets.symmetric(
                  vertical: constriant.maxHeight*0.005,
                  horizontal: constriant.maxWidth*0.02,
                  ),
                color: Colors.white,
                elevation: 4,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=>AugmentedList() ));
                  },
                  child: Card(
                    child: Container(
                      margin:  EdgeInsets.symmetric(
                        vertical: constriant.maxHeight*0.02,
                        horizontal: constriant.maxWidth*0.05,
                      ),
                      height: (
                                MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top ) * 0.07,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: 
                        const [  
                           Text('Augmented Reality Products',
                           style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black,
                          // fontStyle: FontStyle.italic
                            ),
                           ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
                        SizedBox(height: constriant.maxHeight*0.01), 
                        const TrendingProducts(),
                        ProductsGrid()
                ],
               ),
             )
          );
       });
     }
}