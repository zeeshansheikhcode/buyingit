/**
 * This File contain detail of Trending Product
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../video_call/video_conference.dart';
import '../model_provider/cart.dart';
import '../model_provider/products.dart';
import 'detail_chatsearch.dart';
import 'package:toast/toast.dart';

class TrendingDetailScreen extends StatefulWidget {
  
  const TrendingDetailScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/trendingproduct_detail';
  @override
  State<TrendingDetailScreen> createState() => _TrendingDetailScreenState();
}

class _TrendingDetailScreenState extends State<TrendingDetailScreen> {
  //A Screen to show Trending Items Detail
  // final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
     ToastContext().init(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedproduct = Provider.of<Products>(context,listen: false).trendingfindbyId(productId);
    final cart = Provider.of<Cart>(context,listen: false);
    
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(loadedproduct.title,
            style:const TextStyle(
              fontWeight: FontWeight.bold,),
            ),
        ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: 
          [   //SizedBox(height: constraint.maxHeight*0.03,),
              Container(
                 height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.5,
                 width: double.infinity,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                 ),
                 child: Hero(
                  tag: loadedproduct.id,
                  child: Image.network(
                    loadedproduct.productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
           Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: Column(
                children:<Widget>
                [
                  Container(
                  margin:  EdgeInsets.symmetric(
                    horizontal: constraint.maxWidth*0.02,
                    vertical: constraint.maxHeight*0.01),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
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
                      SizedBox(width:  constraint.maxWidth*0.2,),
                       Text(loadedproduct.price.toString().length >=10 
                           ?
                           loadedproduct.price.toString().substring(0,9)
                           :
                           loadedproduct.price.toString(),
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
                  margin:  EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxWidth*0.02,
                  ),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [  
                      const Text(' Description:',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 16,
                       color: Colors.black,
                        ),
                       ),
                     const SizedBox(width: 10,),
                       Text(
                         loadedproduct.description.length >= 30 
                         ?
                         loadedproduct.description.substring(0,25)
                         :
                         loadedproduct.description,
                       style:const TextStyle(
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
             
            
            SizedBox(height: constraint.maxHeight*0.01,),
             Card(  
             margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.0001,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxHeight*0.01,
                  ),
                   height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                      Card(
                        child: InkWell(
                          onTap:()
                           {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const VideoConference()));
                         },
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.04,
                               vertical: constraint.maxHeight*0.01,
                               ),
                                height: constraint.maxHeight * 0.07,
                              width: constraint.maxWidth*0.4,
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
                      
                     Card(
                       child: InkWell(
                         onTap: ()
                         {
                           Navigator.push(context, MaterialPageRoute(builder: 
                           (context)=>  DetailChat(sellername: loadedproduct.seller,)));
                         },
                          child: Container(
                           
                              padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.06,
                               vertical: constraint.maxHeight*0.01,
                               ),
                              height: constraint.maxHeight * 0.07,
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
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:(){
                  cart.addItem(
                  loadedproduct.id, 
                  loadedproduct.price,
                  loadedproduct.title
                  );   
                   Toast.show('Item Added', duration: 2, gravity:Toast.bottom);  
        },
        child: const Icon(Icons.add),
      ),         
    );
 
    });
     }
}
