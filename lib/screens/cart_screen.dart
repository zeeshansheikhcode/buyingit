/**
 * This File Contain Cart Product 
 *  Quantity 
 *  Billing Amount
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/cart.dart';
import '../model_provider/order.dart';
import '../widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({ Key? key }) : super(key: key);
  static const routeName = '/cart_screen';
  // A Screen to show the items in the card and their quantity
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>
        [
          Card(
            margin: const EdgeInsets.all(5),
             child: Padding(
               padding:const EdgeInsets.all(10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>
                 [
                const   Text('Total',
                   style: TextStyle(fontSize: 20),
                   ),
                 const  Spacer(),
                   Chip(label: Text(
                     cart.totalAmount.toString().length > 11 
                      ?
                     'PKR:${cart.totalAmount.toString().substring(0,10)}'
                     :
                     'PKR:${cart.totalAmount.toString()}'
                   ),
                   backgroundColor: Theme.of(context).primaryColor,
                   ),
                   OrderButton(cart: cart),
                 ],
               ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child:ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context,i) =>
              Cart_Item
              (   
                    id:  cart.items.values.toList()[i].id,
             productId:  cart.items.keys.toList()[i],
                 price:  cart.items.values.toList()[i].price,
              quantity:  cart.items.values.toList()[i].quantity,
                 title:  cart.items.values.toList()[i].title,
              ) 
          ),
          ),
        ],
      ),
    );
  }
}
class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: _isLoading ?const  CircularProgressIndicator() : const Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
             // widget.cart.itemCount=0;
              widget.cart.clear();
            },
     // textColor: Theme.of(context).primaryColor,
    );
  }
}
