/**
 * This File contain the Order History of specific user
 */
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/order.dart';
import '../widget/drawer_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({ Key? key }) : super(key: key);
   static const routeName = '/orders';
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}
class _OrderScreenState extends State<OrderScreen> {
   // A Screen to show the items in the Order and their quantity and date
   final storage1 = const FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
   String? value;
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
     value = auth.currentUser!.uid;
  }
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
     final OrdersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const DrawerScreen(),
      body:   
        StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Orders")
       .where('CreatorID' , isEqualTo: value)
       .snapshots(),
      builder: (context, snapshot) 
      {
        if(!snapshot.hasData)
        {
          return const Center(child: CircularProgressIndicator());
        }
        final orders = snapshot.data!.docs;
        final ordersLength = orders.length;
        final List<OrderItem> loadedProducts =[];
        return ListView.builder(
        itemCount  :  ordersLength,
        itemBuilder: (context,index)
        {   
            loadedProducts.add(
                       OrderItem(
                         id:        orders[index]['id'],
                         amount:    orders[index]['amount'],
                         dateTime:  DateTime.parse(orders[index]['dateTime'].toString()),
                         products:  (orders[index]['products'] as List<dynamic>)
                                .map(
                                (item) => CartItem(
                                id      : item['id'],
                                price   : item['price'],
                                quantity: item['quantity'],
                                title   : item['title'],
                                   ),
                               ).toList(),
                         )
                      );
                       if(ordersLength-1 == index)
                      {
                         OrdersData.fetchAndSetOrders(loadedProducts);
                      }

           return  Card(
           margin:const EdgeInsets.all(10),
           child: Column(
           children: <Widget>[
           ListTile(
            title:   Text(
               orders[index]['amount'].toString().length > 10
               ?
               orders[index]['amount'].toString().substring(0,8)
               :
               orders[index]['amount'].toString()
               ),
            subtitle:Text(
              DateFormat('dd/MM/yyyy hh:mm')
                .format(DateTime.tryParse(orders[index]['dateTime'])
                 as DateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding:const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(ordersLength * 20.0 + 10, 100),
              child: ListView(
                children: orders[index]['products']
                    .map<Widget>(
                      (prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                               ' ${prod['quantity']}  x  ${prod['price']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ).toList() ,
                  ),
                )
              ],
             ),
           );
        }
      
          );
         } 
      )
      
     );
    
      
  }
}
