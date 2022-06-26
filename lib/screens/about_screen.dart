/**
 * This File is about the Developer of Application
 * Zeeshan Mehmood Sheikh 2018 UET SCOCS LHR 10
 * Ahsan Chaudhary 2018 UET SCOCS LHR 06
 */
import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SingleChildScrollView(
         child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
           children: 
           [ 
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text('App Developers',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
             ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text('Zeeshan Mehmood Sheikh',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
             ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Text('Muhammad Ahsan Chaudhary',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
             ),

             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                height: 300,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/group_image.jpeg')),
                )
                ),
             ),
            
           ],
         ), 
        ),
    );
  }
}