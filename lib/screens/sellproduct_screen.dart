/**
 * This File contain Uploading Categories and Add Categoris Tab  
 */
import 'package:buying_final/screens/seller_productscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'add_product.dart';
class SellProduct extends StatefulWidget {
  const SellProduct({ Key? key }) : super(key: key);
  @override
  State<SellProduct> createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {  
    final storage = const FlutterSecureStorage();
    String? creatorIdValue;  // Getting Creater ID
    String? selleremail;     // Getting Seller Email
   Future<bool> checkLoginStatus() async
  {
     creatorIdValue = await storage.read(key: "userId"); // Getting User Id from Secure Storage
     selleremail = await storage.read(key: "sellby");    // Getting Seller Email by Secure Storage
    if(creatorIdValue == null)
     {
       return false;
     }
     return true;
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints)
    {
        return Scaffold(
        backgroundColor: Colors.white,
        body:  FutureBuilder(
            future: checkLoginStatus(), //Getting User Attributes from Function
            builder: (BuildContext context,AsyncSnapshot<bool> snapshot)
               {
                 if(snapshot.data== false)
                  {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const Center(child: CircularProgressIndicator(),);
                  }
        return 
         SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>
           [   // Card Which holds everything on Screen
             Card(
                 color: Colors.white,
                 margin:  EdgeInsets.symmetric(vertical: constraints.maxHeight*0.01,horizontal: constraints.maxWidth*0.02),         
                 child: Container(
                   padding: const EdgeInsets.all(10.0),
                   height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.9,
                   child: SingleChildScrollView(
                     child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     SizedBox(height: constraints.maxHeight*0.02,),
                     const  Text('Select Category For Selling',
                          style: TextStyle(fontSize: 25,
                          fontWeight: FontWeight.bold,
                            ),   
                          ),
                     SizedBox(height: constraints.maxHeight*0.02,),
                     Card(  
                     margin:  EdgeInsets.symmetric(
                     vertical: constraints.maxHeight*0.01,
                     horizontal: constraints.maxWidth*0.02,
                      ),
                    color: Colors.white,
                    elevation: 4,
                     child: InkWell(
                     onTap:()
                       {  // Navigate to User Products
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=> const SellerProductScreen()));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Uploaded Products',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                     SizedBox(height: constraints.maxHeight*0.02,),
                     // Card For Specific Category
                        Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                    horizontal:  constraints.maxWidth*0.02 
                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(
                          title : 'Shawarma',
                          createrIDvalue : creatorIdValue!,
                          sellby : selleremail!,
                          )));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Shawarma',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Burger', createrIDvalue : creatorIdValue!,
                         sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Burger',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Pizza', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Pizza',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Sandwich', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Sandwich',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(height: constraints.maxHeight*0.02,),
                                  // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Home Applaince', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Home Applaince',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Fashion', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Fashion',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Real Estate', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Real Estate',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.02,),
                                   // Card For Specific Category
                                     Card(  
                        margin:  EdgeInsets.symmetric(
                      vertical:  constraints.maxHeight*0.01,
                                     horizontal:  constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                     onTap:()
                       {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        AddProduct(title : 'Hardware', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                       },
                                     child: Card(
                      child: Container(
                          margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('Hardware',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.normal
                              ),
                             ),
                          ],
                        ),
                      ),
                                     ),
                                   ),
                                 ),
                       SizedBox(height: constraints.maxHeight*0.01,),
                        // Card For Specific Category
                        Card(  
                                   margin:  EdgeInsets.symmetric(
                                     vertical: constraints.maxHeight*0.01,
                                     horizontal: constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                                     onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                           AddProduct(title : '360 Product', createrIDvalue : creatorIdValue!, sellby : selleremail!,)));
                        } ,
                                     child: Card(
                      child: Container(
                        margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('  360 View Products',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             
                              ),
                             ),
                          ],
                        ),
                      ),
                  ),
                 ),
               ),      
                     SizedBox(height: constraints.maxHeight*0.01,),
             
                Card(  
                                   margin:  EdgeInsets.symmetric(
                                     vertical: constraints.maxHeight*0.01,
                                     horizontal: constraints.maxWidth*0.02,
                                     ),
                                   color: Colors.white,
                                   elevation: 4,
                                   child: InkWell(
                                     onTap:(){
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                          //  AddProduct(value : '360 Product', createrIDvalue : creatorIdValue!)));
                        } ,
                                     child: Card(
                      child: Container(
                        margin:  EdgeInsets.symmetric(
                          vertical: constraints.maxHeight*0.02,
                          horizontal: constraints.maxWidth*0.05,
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
                             Text('All END',
                             style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 22,
                             color: Colors.black,
                             fontStyle: FontStyle.italic
                              ),
                             ),
                          ],
                        ),
                      ),
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
       );
       
               },),    
    );
 
    });
    }
}