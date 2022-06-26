/**
 * This File Contains :
 * Provider Product Function
 * Add Product
 * Fetch Product
 * Delete Product
 * Update Product
 */
import 'package:buying_final/model_provider/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';
class Products with ChangeNotifier
{
   
   final storage = const FlutterSecureStorage();
   List<Product>? _items = [];
   String? userID ;
   Products(this.userID,this._items);
   List<Product> get items 
   {
     return [..._items!];
   }
   
    final List<Product>? _trendingItems = 
   [
      Product(
      id: '1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      quantity: 2,
      price: 300.0,
      category: 'Fashion',
      CreatorID: '5zQzOvStuEePGbX4Tvk6NMB1RDp1',
      seller: 'zeeshan@gmail.com',
      productImage:'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: '2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 400.0,
      quantity: 2,
      category: 'Fashion',
      CreatorID: '5zQzOvStuEePGbX4Tvk6NMB1RDp1',
      seller: 'zeeshan@gmail.com',
      productImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: '3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 100.0,
      quantity: 2,
      category: 'Fashion',
      CreatorID: '5zQzOvStuEePGbX4Tvk6NMB1RDp1',
      seller: 'zeeshan@gmail.com',
      productImage:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: '4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 90.0,
      quantity: 2,
      seller: 'zeeshan@gmail.com',
      category: 'Augmented Product',
      CreatorID: '5zQzOvStuEePGbX4Tvk6NMB1RDp1',
      productImage:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
     Product(
      id: '5',
      title: 'Pizza Tikka',
      description: 'Pizza with Tikka botti.',
      price: 500.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Pizza',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395__480.jpg',
    ),
     Product(
      id: '6',
      title: 'Pizza Chicken',
      description: 'Pizza with chicken pieces.',
      price: 400.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Pizza',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://cdn.pixabay.com/photo/2017/02/15/10/57/pizza-2068272__340.jpg',
    ),
    Product(
      id: '7',
      title: 'Pizza Spicy',
      description: 'Pizza with multiple masala',
      price: 400.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Pizza',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062__340.jpg',
    ),
    Product(
      id: '8',
      title: 'Greek Pizza ',
      description: 'Exotic Pizza from Greece',
      price: 500.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Pizza',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://c8.alamy.com/zooms/9/17de0e561eea4835ac19a16a00e32fd4/2b1gcgf.jpg',
    ),
     Product(
      id: '9',
      title: 'Beef Burger',
      description: 'Burger with Halal Meat',
      price: 600.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Burger',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://www.foodiesfeed.com/wp-content/uploads/2019/07/confited-duck-burger.jpg',
    ),
     Product(
      id: '10',
      title: 'Turkey Burger',
      description: 'Burger from Istanbul taste ',
      price: 600.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Burger',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://www.freepnglogos.com/uploads/burger-png/burger-png-transparent-images-download-clip-art-30.png',
    ),
      Product(
      id: '11',
      title: 'Chicken Burger',
      description: 'Burger with chicken pieces',
      price: 500.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Burger',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://i.pinimg.com/736x/01/01/45/010145f0e8567d435097c7b72846afb1--travel-to-cuba-lamb-burgers.jpg',
    ),
    Product(
      id: '12',
      title: 'Spicy Shawarma',
      description: 'Hot Spicy Shawarma',
      price: 120.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Shawarma',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://t3.ftcdn.net/jpg/02/55/42/50/360_F_255425068_CyDrGsVcu1Bl2SdJ2yXx35Rlp8jyNCCQ.jpg',
    ),
     Product(
      id: '13',
      title: 'Beef Shawarma',
      description: 'Halal Meat Pieces',
      price: 120.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Shawarma',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://cdn.pixabay.com/photo/2021/03/20/14/31/shawarma-6109976__340.jpg',
    ),
     Product(
      id: '14',
      title: 'Chicken Shawarma',
      description: 'Shawarma with chicken pieces',
      price: 120.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Shawarma',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://thumbs.dreamstime.com/b/doner-kebab-shawarma-wrap-grilled-chicken-lavash-pita-bread-fresh-vegetables-tomatoes-green-salad-peppers-old-wooden-140579941.jpg',
    ),
    Product(
      id: '15',
      title: 'Chicken Sandwich',
      description: 'Delicious chicken pieces',
      price: 120.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Sandwich',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://imagesvc.meredithcorp.io/v3/mm/image?q=60&c=sc&poi=face&w=960&h=480&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F44%2F2019%2F08%2F26230801%2F4549578.jpg',
    ),
    Product(
      id: '16',
      title: 'Beef Sandwich',
      description: 'Halal Meat in Sandwich',
      price: 120.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Sandwich',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F19%2F2018%2F06%2F15%2Fmr-grilled-peanut-butter-jelly-sandwich-2000.jpg',
    ),
     Product(
      id: '17',
      title: 'British Pant',
      description: 'English Pant ',
      price: 800.0,
      quantity: 2,
      seller: 'ahsan@gmail.com',
      category: 'Fashion',
      CreatorID: 'cc8QVp6ukuOhouEzBr2gJABKm843',
      productImage:
          'https://i.pinimg.com/474x/63/b4/a3/63b4a30516172bf9c3c5b43acb9c9d63.jpg',
    ),
     Product(
      id: '18',
      title: 'Outfitter Dress',
      description: 'A beautiful dress ',
      price: 1000.0,
      quantity: 2,
     seller: 'ahmed@gmail.com',
      category: 'Fashion',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2021%2F10%2F25%2Fgrace-karin-women-retro-long-sleeve-ruched-wrap-party-pencil-dress-brown.jpg',
    ),
    Product(
      id: '19',
      title: 'Cavalary House',
      description: 'A place near Defence',
      price: 1000000,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Real Estate',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070__480.jpg',
    ),
     Product(
      id: '20',
      title: 'Bahria Orchard House',
      description: 'Your new House',
      price: 2000000,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Real Estate',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://st.depositphotos.com/1194063/2151/i/600/depositphotos_21515189-stock-photo-agent-with-house-model-and.jpg',
    ),
     Product(
      id: '21',
      title: 'Flat 3BHK',
      description: 'For Couples only',
      price: 400000,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Real Estate',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://cdn.corporatefinanceinstitute.com/assets/real-estate.jpeg',
    ),
    Product(
      id: '22',
      title: 'Roti Maker',
      description: 'Prepare any roti you want.',
      price: 450,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Home Appliance',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://i.pinimg.com/736x/58/ef/b2/58efb234576d5adbbcb9b99ebcfc7d26.jpg',
    ),
     Product(
      id: '23',
      title: 'Philips Appliance ',
      description: 'Philips provides you all electronic',
      price: 20000,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Home Appliance',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://www.arabnews.pk/sites/default/files/styles/n_670_395/public/2020/09/11/2265811-996621850.jpg?itok=cPsnW4VM',
    ),
     Product(
      id: '24',
      title: 'Plazz',
      description: 'Used in mechanical work',
      price: 130.0,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Hardware',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://5.imimg.com/data5/LK/AM/EA/SELLER-25167820/electric-plass-500x500.jpg',
    ),
     Product(
      id: '25',
      title: 'Instruments',
      description: 'For mechanic safety',
      price: 2000.0,
      quantity: 2,
      seller: 'ahmed@gmail.com',
      category: 'Hardware',
      CreatorID: 'KC1SimMVIEN26L7TLGmeRka9sCH3',
      productImage:
          'https://image.shutterstock.com/image-photo/inverter-welding-machine-equipment-isolated-260nw-450564319.jpg',
    ),
   ];
   
   List<Product> get trendingItems
   {
     return [..._trendingItems!];
   }
   //finding Product by ID
  Product findbyId(String id)
  {
    return _items!.firstWhere((prod) => prod.id == id);
  }
  //finding Trending Product by ID
  Product trendingfindbyId(String id)
  {
    return _trendingItems!.firstWhere((prod) => prod.id == id);
  }
      FirebaseAuth auth = FirebaseAuth.instance;     
      String? value; // Creater ID
      Future<bool> checkUserId() async
     { 
         value = auth.currentUser!.uid; // Getting Creator ID
         if(value == null)
          {
            return false;
          }
          return true;
      }
      //Fetching User Products
  void fetchAndSetProducts() async
  {   
    try
    {
     final userId = FirebaseAuth.instance.currentUser!.uid; 
     final QuerySnapshot snapshot = await FirebaseFirestore.instance
       .collection("Products")
       .where("CreatorID", isEqualTo: userId)
       .get(); 
      if(snapshot.docs == null)
      {
        return ;
      }
     final productlist = snapshot.docs.map((doc) => Product.fromDocument(doc)).toList();
     _items = productlist;
     notifyListeners();
    }
      catch(error)
       {
         print(error);
       }
  }
  //Adding User Products
  Future<void> addproducts(Product product) async
  {   final String productuid = const Uuid().v4().substring(0,7);
    try
    { 
         await FirebaseFirestore.instance.collection('Products')
             .doc(productuid)
             .set({
                'id'          : productuid,
                'title'       : product.title,
                'price'       : product.price,
                'quantity'    : product.quantity,
                'description' : product.description,
                'productImage': product.productImage,
                'CreatorID'   : product.CreatorID,
                'category'    : product.category,
                'seller'      : product.seller,
               });    
     final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      productImage: product.productImage,
      quantity: product.quantity,
      id: productuid,
      category: product.category,
      CreatorID: product.CreatorID,
      seller: product.seller,
    );
    _items!.add(newProduct);
    notifyListeners();
    }
     catch(error)
     {
      //print(error);
      throw error;
     }
  }
  //Updating User Products
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items!.indexWhere((prod) => prod.id == id);
    if (prodIndex != null)
    {  
       
          FirebaseFirestore.instance.collection('Products')
           .doc(id)
           .update({
             'id'            : newProduct.id,
             'title'         : newProduct.title,
             'price'         : newProduct.price,
             'quantity'      : newProduct.quantity,
             'description'   : newProduct.description,
             'productImage'  : newProduct.productImage,
             'CreatorID'     : newProduct.CreatorID,
             'category'      : newProduct.category,
             'seller'        : newProduct.seller,
           });
       
      _items![prodIndex] = newProduct;
      notifyListeners();
    } else {
     // print('...');
    }
  }
  //Deleting User Products
  Future<void> deleteProduct(String id) async
   {
        await  FirebaseFirestore.instance.collection('Products')
        .doc(id)
        .delete();
      final existingProductIndex = _items!.indexWhere((prod) => prod.id ==id);
      var   existingProduct = _items![existingProductIndex];
            _items!.removeAt(existingProductIndex); 
            notifyListeners();     
  }
}