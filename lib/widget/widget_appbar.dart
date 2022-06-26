/**
 * This File Contain Appbar used in all app
 */
import 'package:buying_final/widget/search.dart';
import 'package:flutter/material.dart';
PreferredSize CustomAppbar(BuildContext context){
  return  PreferredSize(
    preferredSize:const Size.fromHeight(60),
    child: AppBar(
         title: const Text('Buying It',
         style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
          ),
         ),
         centerTitle: true,
          actions: 
           [  
                      IconButton(onPressed: ()
                   {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SearchPage()));               
                   },
                   icon: const Icon(Icons.search,size: 25,)
                   ),
           ], 
       ),
  );
}