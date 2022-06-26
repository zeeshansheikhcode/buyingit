/**
 * this File contain Grid View of all Augmented Products in Our App
 */
import 'package:buying_final/augmented_products/augmented_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/products_model.dart';
class AugmentedList extends StatefulWidget {
  @override
  _AugmentedListState createState() => _AugmentedListState();
}

class _AugmentedListState extends State<AugmentedList> {
  String _platformVersion = 'Unknown';
  static const String _title = 'Augmented Reality Products';
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await ArFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  List<Product> actualProducts =
  [
                Product(
                      id:            '01',
                      title:         'Lock',
                      description:   'Augmented View Of Lock',
                      price:         1000,
                      quantity:      5,
                      productImage:  'assets/15.jpg',
                      category:      'Augmented Reality',
                      CreatorID:     'qwertyu',
                      seller:        'zeeshan@gmail.com', 
                      ),
                 Product(
                      id:            '02',
                      title:         'Skull',
                      description:   'Augmented View Of Mask',
                      price:          600,
                      quantity:       50,
                      productImage:  'assets/1654461909974.jpg',
                      category:      'Augmented Reality',
                      CreatorID:     'qwertyu',
                      seller:        'zeeshan@gmail.com', 
                      ),
                    Product(
                      id:            '03',
                      title:         'Chicken',
                      description:   'Augmented View Of Mask',
                      price:          600,
                      quantity:       50,
                      productImage:  'assets/chicken.jpg',
                      category:      'Augmented Reality',
                      CreatorID:     'qwertyu',
                      seller:        'zeeshan@gmail.com', 
                      ),
                
  ];
  @override
  Widget build(BuildContext context) {
  final cart = Provider.of<Cart>(context,listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title,style: TextStyle(fontSize: 18),),
        ),
        body: Column(
          children: 
          [
          Text('Running on: $_platformVersion\n'),
          Text('Android version must be greater than \n' 
               'or equal to 11\n'),
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
             itemCount:actualProducts.length,
             itemBuilder: (context,index)
             {       
                 return  Container(
                 margin: const EdgeInsets.symmetric(vertical: 5),
                 child: ClipRRect(
                 borderRadius: BorderRadius.circular(15),
                 child: GridTile(
                 child:  GestureDetector(     
                 onTap: ()
                 { 
                 
                  if(actualProducts[index].id=='01')
                   {
                     
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const 
                      AugmentedView(addresspath: "assets/ar_folder/1652701284980/out.gltf",)));    
                   }
                   else if(actualProducts[index].id=='02')
                   {
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const 
                    AugmentedView(addresspath: "assets/ar_folder/1654462633238/out.gltf",)));    
                   }
                   else
                   {
                     Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => const 
                     AugmentedView(addresspath: "assets/ar_folder/Chicken_01/Chicken_01.gltf",)));    
                   }
                  
                   },
            child: 
            Image(
              image:AssetImage(actualProducts[index].productImage),
              fit:BoxFit.cover    
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
           )
        ]),
      ),
    );
  }
}
