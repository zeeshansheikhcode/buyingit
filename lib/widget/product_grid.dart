/**
 * This File contain code of All Product of Specific User
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import '../screens/detail_screen.dart';
class ProductsGrid extends StatefulWidget {
   const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  
  // A functon which first when activity comes
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<Products>(context,listen: false).fetchAndSetProducts(); // Getting Specific User Product
  }
  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<Products>(context,listen: false); // Creating Provider Object Of Product
    final products = productdata.items;                               // Getting Product List
    final cart = Provider.of<Cart>(context,listen: false);            // Creating Provider Object Of Cart
     List<Product> loadedProducts =[];                                // A List with All Product
     List<Product> actualProducts =[];                                // A List of Secific Product
          for(int index = 0 ;index<products.length;index++)
          { 
            //Adding Products in List
            loadedProducts.add(
                    Product(
                      id:            products[index].id,
                      title:         products[index].title,
                      description:   products[index].description,
                      price:         products[index].price,
                      quantity:      products[index].quantity,
                      productImage:  products[index].productImage,
                      category:      products[index].category,
                      CreatorID:     products[index].CreatorID,
                      seller:        products[index].seller, 
                      )
                      );
                      if(
                         products[index].category !='360 Product'
                         &&
                         products[index].category !='Augmented Product'
                         )
                   {
                    //Adding Products in List
                      actualProducts.add(
                      Product(
                        id:          products[index].id,
                      title:         products[index].title,
                      description:   products[index].description,
                      price:         products[index].price,
                      quantity:      products[index].quantity,
                      productImage:  products[index].productImage,
                      category:      products[index].category,
                      CreatorID:     products[index].CreatorID,
                      seller:        products[index].seller,                
                          )
                        );
                   }
          } 
             
         return          
           GridView.builder( // Showing data in Grid View
            padding: const EdgeInsets.all(10),
             shrinkWrap: true,
             physics:const NeverScrollableScrollPhysics(),
             gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              mainAxisExtent: 175,
              crossAxisSpacing: 10,
               ),
             itemCount:actualProducts.length,
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
              DetailScreen.routeName ,
                 arguments: actualProducts[index].id);
            },
            child: Hero(
              tag: actualProducts[index].id,
              child: FadeInImage(
                  placeholder:const AssetImage('assets/images/product-placeholder.png'),
                  image: NetworkImage(actualProducts[index].productImage),
                  fit:BoxFit.cover,
                  ),
              ),
            ),
         footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
         actualProducts[index].title,
          textAlign: TextAlign.justify,
          ),
          trailing: IconButton
          (
           onPressed: (){  
             cart.addItem(
                  actualProducts[index].id, 
                  actualProducts[index].price,
                  actualProducts[index].title
                  );      
             Scaffold.of(context).hideCurrentSnackBar();
             Scaffold.of(context).showSnackBar(
              const  SnackBar(content:  Text('Added Item to Cart'),
                 duration:  Duration(seconds: 2),
                //  action: SnackBarAction(label: 'UNDO', 
                //  onPressed: (){
                //     }),
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
           );
      }          
} 

