/**
 * This File contain
 * Cart Model
 * Cart Provider Function
 * Add Item
 * Remove Item
 * Clear Cart
 */
import 'package:flutter/foundation.dart';
class CartItem
{
   //Cart Model Attributes
   String id;
   String title;
   int quantity;
   double price;
   String? productId;

  CartItem({
  required this.id,
  required this.title,
  required this.quantity,
  required this.price,
   this.productId
    });
}
class Cart with ChangeNotifier{
  Map<String,CartItem> _items = {};
  Map<String,CartItem> get items {
    return {..._items};
  }
  int _counter = 0;

  int get itemCount {
 
    return _counter;
  }
  double get totalAmount {
    var total=0.0;
    _items.forEach((key, cartItem)
     { 
       total += cartItem.price * cartItem.quantity;
     });
     return total;
  }
 //Adding Item to Cart function
  void addItem(String productId,double price,String title)
  {  
    if(_items.containsKey(productId))
     {
       _items.update(
         productId,
        (existingCartItem) => CartItem(
                id: existingCartItem.id,
             title: existingCartItem.title,
             price: existingCartItem.price,
          quantity: existingCartItem.quantity+1, 
        )
      );
     }
     else
     {
       _items.putIfAbsent(
         productId,
          () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1
        ));
     }
     _counter++;
     notifyListeners();
  }
  //Adding Item to Cart function
  void removeItem(String productId)
  {
    _items.remove(productId);
    notifyListeners();
  }
  //Clear Cart function
  void clear() {
    _items = {};
    _counter =0;
    notifyListeners();
  }
}