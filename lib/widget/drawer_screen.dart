/**
 * This File contain  Listtile  of:
 * User Profile
 * Home
 * Order
 * Cart
 * About
 * LogOut Function
 */
import 'package:buying_final/screens/about_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../authenticate/login_screen.dart';
import '../model_provider/auth.dart';
import '../screens/cart_screen.dart';
import '../screens/home_screen.dart';
import '../screens/order_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({ Key? key }) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final storage = const FlutterSecureStorage();
    String? creatorvalue; //UserID
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
     creatorvalue = _auth.currentUser!.uid;
  }

   @override
   Widget build(BuildContext context) {
     final auth = Provider.of<Auth>(context);
    return _auth.currentUser==null
           ?
           const Center(child: Text('No Profile, Go to Login'),)
           : 
         Drawer(
         child:     
           StreamBuilder<DocumentSnapshot>(
                   stream: FirebaseFirestore.instance.collection("users")
                   .doc(creatorvalue)
                   .snapshots(),
                   builder: (context, snapshot) 
                   { 
            if(!snapshot.hasData)
            {
               return  Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:const [
                   Text('Loading Profile'),
                   SizedBox(height: 30,),
                   Center(child: CircularProgressIndicator()),
                 ],
               ));       
            }
            if(snapshot.connectionState == ConnectionState.waiting)
            {
               return const Center(child: CircularProgressIndicator());       
            }
                   final  userinfo  =   snapshot.data!;
                    return Container(
                     color: Colors.white,
                     child: SafeArea(
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           UserAccountsDrawerHeader(
                           accountName: Text(userinfo['username']), 
                           accountEmail: Text(userinfo['email']),
                           decoration: const BoxDecoration(
                             image: DecorationImage(image: AssetImage('assets/images/background.jpg'), 
                             fit:  BoxFit.cover),
                           ),
                           currentAccountPicture:  CircleAvatar(
                             backgroundImage: NetworkImage(userinfo['photoUrl']),
                           ),
                           ),
                            const  Divider(
                             thickness: 2,
                             color: Colors.black,
                             ),
                           ListTile(
                             title  :  const Text('Home',style: TextStyle(color: Colors.black),),
                             leading:  const Icon(Icons.home,color: Colors.black,),
                             onTap: ()
                             {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                             },
                           ),
                           ListTile(
                             title  :  const Text('Cart',style: TextStyle(color: Colors.black),),
                             leading:  const Icon(Icons.shopping_cart,color: Colors.black,),
                             onTap: ()
                             {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartScreen()));
                             },
                           ),
                            ListTile(
                             title  :  const Text('Order',style: TextStyle(color: Colors.black),),
                             leading:  const Icon(Icons.person,color: Colors.black,),
                             onTap: ()
                             {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderScreen()));
                             },
                           ),   
                          //   draweritem(
                          //    name: 'About',
                          //    iconData: Icons.warning
                          //  ),
                      const  Divider(
                             thickness: 2,
                             color: Colors.black,
                             ),
                     const  ListTile(leading: Text('Communicate',
                            style: TextStyle(fontSize: 20,color: Colors.black),) 
                          ,),
                          ListTile(
                             title  :  const Text('About',style: TextStyle(color: Colors.black),),
                             leading:  const Icon(Icons.work,color: Colors.black,),
                             onTap: ()
                             {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AboutScreen()));
                             },
                           ),
                             ListTile(
                             title  :  const Text('Log Out',style: TextStyle(color: Colors.black),),
                             leading:  const Icon(Icons.logout,color: Colors.black,),
                             onTap: () async
                             {
                             
                                 await auth.logOut(context); 
                                 Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                                 },
                           ),
                          
                         ],),
                     ),
                             );
                  }
                )
         );
               }   
  }

  

 