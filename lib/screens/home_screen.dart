/**
 * This file contain the Bottom Navigation Bar Tabs
 * MenuScreen
 * Chat
 * Cart
 * SellProduct
 */
import 'package:buying_final/screens/cart_screen.dart';
import 'package:buying_final/screens/sellproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../chatting/chatsearch.dart';
import '../widget/drawer_screen.dart';
import '../widget/widget_appbar.dart';
import 'menu_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  const HomeScreen({ Key? key }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int page =0;  // Current Page
    List pageoptions =  // All Page Option
   const [
      MenuHomeScreen(),
      SellProduct(),
      CartScreen(),
      ChatSearch(),
      
    ];
    // Caling myStyle from variable file for decoration
   TextStyle myStyle(double size,[Color? color,FontWeight fw = FontWeight.w700])
  {
    return GoogleFonts.montserrat(
     fontSize: size,
     fontWeight:  fw,
     color: color,
   );
  }

  @override
  Widget build(BuildContext context) { 
   return Scaffold(
     appBar:  CustomAppbar(context), // Calling Custom AppBar from Widget folder
     drawer: const DrawerScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: myStyle(14,Colors.blue), // Caling myStyle from variable file for decoration
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: myStyle(14,Colors.black), // Caling myStyle from variable file for decoration
        currentIndex: page,
        onTap: (index){
          setState(() {
            page = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: 
       const  
       [    //Giving name and icon to bottom navigation bar
            BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home,size:24,)
            ),
            BottomNavigationBarItem(
            label: 'Sell',
            icon: Icon(Icons.shopping_bag,size:24,),
            ),
            BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart,size:24,),
            ),
             BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat,size:24,)
            ),
        ]),
       body: pageoptions[page], // Showing which screen should display on tap
    );
  }
 
}
