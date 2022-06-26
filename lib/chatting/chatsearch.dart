/**
 * This File contain the searching of User from function
 */
import 'package:buying_final/video_call/video_conference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_room.dart';
class ChatSearch extends StatefulWidget 
{
  const ChatSearch({ Key? key }) : super(key: key);
  @override
  _ChatSearchState createState() => _ChatSearchState();
}
class _ChatSearchState extends State<ChatSearch> with WidgetsBindingObserver{
    Map<String,dynamic>? usermap;        
    bool isLoading = false;
  //  bool errorvar = true;
    final TextEditingController _search = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     @override
     void  initState()
     { super.initState();
       WidgetsBinding.instance.addObserver(this);
       setStatus("Online");
     }
     void setStatus(String status) async
     { 
       await _firestore.collection('users').doc(_auth.currentUser!.uid).update({ "status" : status});
     }
     @override
     void didChangeAppLifecycleState(AppLifecycleState state)
     {
       if(state==AppLifecycleState.resumed)
       {
          setStatus("Online");
       }
       else
       {
         setStatus("Offline");
       }
     }
   
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else 
    {
      return "$user2$user1";
    }
  }
  showAlertDialog(BuildContext context)
{
  Widget okButton = TextButton(
    child:const Text("OK"),
    onPressed: () 
    {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("No User with this Email"),
    content:const Text("Please enter valid Email"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
     void onSearch(BuildContext context)async
     { 
       FirebaseFirestore _firestore = FirebaseFirestore.instance;
       setState(() {
         isLoading = true;
       });
       try
       {
         await  _firestore
         .collection('users')
         .where("email",isEqualTo: _search.text)
         .get()
         .then((value)
          {
            setState(() {
              usermap = value.docs[0].data();
              isLoading=false;
            });
          
          });
       }
       catch(e)
       { 
        
         setState(() {
            isLoading = false;
          });
          showAlertDialog(context);
       }
       
     }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraint)
      {
        return Scaffold(
         appBar: AppBar(
         centerTitle: true,
         title: const  Text('Search Seller Or Buyer by Email',
         style: TextStyle(fontSize: 16),),
       ),
       body: isLoading ?
          const Center(
              child:  CircularProgressIndicator(),
            )
          :
          SingleChildScrollView(
            child:  Column(
               children: 
               [ 
                 SizedBox(height: constraint.maxHeight*0.02),
                 Container(
                   height: constraint.maxHeight*0.2,
                   width: constraint.maxWidth*1.0,
                   alignment: Alignment.center,
                   margin: EdgeInsets.symmetric(horizontal: constraint.maxWidth*0.05),
                   child: SizedBox(
                    height: constraint.maxHeight*0.15,
                     width: constraint.maxWidth*1.0,
                     child: TextField(
                       controller: _search,
                       decoration: InputDecoration(
                         hintText: "Search",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: constraint.maxHeight*0.02,),
                 Card(
                        child: InkWell(
                          onTap:()
                            {
                              onSearch(context);
                            },
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.17,
                               vertical: constraint.maxHeight*0.01,
                               ),
                              height: constraint.maxHeight * 0.09,
                              width: constraint.maxWidth*0.6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('Search ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),) ,
                          ),
                        ),
                      ),
                 
                 SizedBox(height: constraint.maxHeight*0.01),
                 Card(
                        child: InkWell(
                          onTap:()
                           {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const VideoConference()));
                         },
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.15,
                               vertical: constraint.maxHeight*0.01,
                               ),
                              height: constraint.maxHeight * 0.09,
                              width: constraint.maxWidth*0.6,
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
                  usermap != null
                   ?
                   ListTile(
                     onTap: ()
                     {
                       String roomId = chatRoomId(
                                    _auth.currentUser!.displayName!,usermap!['username']);
    
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                        ChatRoom(  chatRoomId : roomId,
                                   userMap  : usermap!,
                                   ) ,
                          ));
                          
                     },
                     leading:const Icon(Icons.account_box, color: Colors.black,
                     ),
                     title: Text(
                       usermap!['username'],
                       style: const TextStyle(
                         color: Colors.black,
                         fontSize: 17,
                         fontWeight: FontWeight.w700,
                       ),
                     ),
                     subtitle: Text(usermap!['email']),
                     trailing:const Icon(Icons.chat,color: Colors.black,),
                   )
                   :
                    // errorvar == true 
                    // ?
                    Container()
                    // :
                    // showAlertDialog(context)
               ],
            ),
          ),  
      );
      }
    );

      }    
    }

