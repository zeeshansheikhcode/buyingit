/**
 * This File contain All Food Detail about Specific Product
 */
import 'package:flutter/material.dart';
 class FoodDetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String price;
  const FoodDetailScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);
  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
     return LayoutBuilder(builder: (context,constraint)
     {
      return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: 
          [  const SizedBox(height: 25,),
              Container(
                height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.45,
                          width: constraint.maxWidth*1.0,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                 ),
                 child: Image(image: AssetImage(widget.imageUrl))
                ),
            // const Text('Price   10000'),
            // const Text('Description Diamond biscuit Dimond\n biscuit la loo mummy\n papa jab bhi ataa saraa bacha khush hojataa')
              Card(  
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              elevation: 4,
              child: Column(
                children:<Widget>
                [
                  Container(
                  margin: const EdgeInsets.all(10),
                  height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.07,
                          width: constraint.maxWidth*1.0,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                     const  Text(' Price: ',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.black,
                        ),
                       ),
                     const SizedBox(width: 50,),
                       Text(widget.price,
                       style:const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                 height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.07,
                          width: constraint.maxWidth*1.0,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                  const  [  
                       Text(' Description:',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.black,
                        ),
                       ),
                      SizedBox(width: 10,),
                       Text('Made in Italy ',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),     
                ] 
              ),
            ),
            
           const SizedBox(height: 10,),
             Card(  
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.07,
                          width: constraint.maxWidth*1.0,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                      Card(
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                               horizontal:20,
                               vertical: 5),
                           height:(
                              MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top ) * 0.1,
                            width: constraint.maxWidth*0.42,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('Video Call',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),) ,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 50,),
                     Card(
                       child: InkWell(
                          child: Container(
                           //  margin: const EdgeInsets.symmetric( horizontal:10),
                            padding: const EdgeInsets.symmetric(
                               horizontal:20,
                               vertical: 5),
                             height:(
                              MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top ) * 0.1,
                            width: constraint.maxWidth*0.4,
                            decoration: const BoxDecoration(
                              
                              color: Colors.white,
                            ),
                            child: const Text('Chat',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          ),
                        ),
                     ),
                    ],
                  ),
                ),
              ),
            ),
           ],
        ),
      ),
    //  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child:const Icon(Icons.shopping_cart),
      ),     
    );
 
     });
     }
}