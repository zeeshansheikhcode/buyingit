/**
 * This File is the Gate of Our Application
 * Contain Main Function,
 * Routes,
 * Splash Screen, 
 * Providers
 * Also Check Login Function
 */
import 'dart:async';
import 'package:buying_final/authenticate/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:buying_final/screens/add_product.dart';
import 'package:buying_final/screens/cart_screen.dart';
import 'package:buying_final/screens/detail_screen.dart';
import 'package:buying_final/screens/home_screen.dart';
import 'package:buying_final/screens/trending_detailscreen.dart';
import 'authenticate/login_screen.dart';
import 'model_provider/auth.dart';
import 'model_provider/cart.dart';
import 'model_provider/order.dart';
import 'model_provider/products.dart';


//main function of app which run the application from start
Future<void> main()  async
{
  //Attaching Firebase to  our app and setting orientation
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  //runApp is fuction which run the app
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> 
{
  final storage = const FlutterSecureStorage();
  
    //Checking Login status by User Id
  Future<bool> checkLoginStatus() async
  {
    String? value =await storage.read(key: "userId");
    if(value == null)
     {
       return false;
     }
     return true;
  }
  @override
  Widget build(BuildContext context) {
    //Using Multi Provider State Management 
    return MultiProvider(
      providers: 
    [
        ChangeNotifierProvider(
         create:(context)=> Auth(),
          ),
         ChangeNotifierProxyProvider<Auth,Products>
        ( 
          create: (context)=>Products('',[]),
          update: (context,auth,previousprod) =>
              Products(
                auth.userId,
                previousprod == null ? [] :previousprod.items)
        ),
        ChangeNotifierProxyProvider<Auth,Orders>
        ( 
          create: (context)=>Orders('',[]),
          update: (context,auth,previousorder) =>
              Orders(
                auth.userId,
                previousorder == null ? [] :previousorder.orders)
        ),
      ChangeNotifierProvider(
      create: (context)=> Cart(),
      ),
    ],
       child:   MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Buying It',
          theme: ThemeData(
          primarySwatch:Colors.blue,
          accentColor: Colors.lightBlueAccent,
          ),
          //Using Future builder to collect future for Which screen should display
          home:  FutureBuilder(    
            future: checkLoginStatus(),            // Waiting for user id in future
            builder: (BuildContext context,AsyncSnapshot<bool> snapshot)
               {
                 if(snapshot.data== false)
                  {
                    return const LoginScreen();    // Calling Login Screen if user Id is null
                  }
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const SplashScreen();   // Showing Splash Screen if connecting with server
                  }
                  return const HomeScreen();      //  Showing Home Screen if user is already logged
               },),
          //Generating and Initializing routes which are main routes in application
          routes: 
          {
           DetailScreen.routeName : (context)         => const DetailScreen(),
           AddProduct.routeName   : (context)         => const AddProduct(title:'', createrIDvalue: '',sellby: '', ),
           CartScreen.routeName   : (context)         => const CartScreen(),
           LoginScreen.routeName  : (context)         => const LoginScreen(),
           SignUpScreen.routeName : (context)         => const SignUpScreen(),
           HomeScreen.routeName   : (context)         => const HomeScreen(),
           TrendingDetailScreen.routeName  :(context) => const TrendingDetailScreen(),   
          }
      ),     
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          const [
             Text('Buying It',
                   style: TextStyle(
                   fontSize: 30,
                   fontWeight: FontWeight.bold,
                   color: Colors.black,
                  ),
                ),
             SizedBox(height: 10,),
             Text('Pay for what you see',
                    style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),
                SpinKitThreeBounce(
                color: Colors.black,
                size: 30.0,
             ),
          ],
        ),
      ), 
    );
  }
}
