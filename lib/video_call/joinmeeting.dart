/**
 * This file contain Name ,Camere, Audio setting about User
 * Pin code to enter to join specific meeting
 */
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../widget/variables.dart';
class JoinMeeting extends StatefulWidget {
  const JoinMeeting({ Key? key }) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController roomcontroller = TextEditingController();
  bool isaudiomuted = true;
  bool isvideomuted = true;
  String username='';
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }
  getuserdata() async
  {
    DocumentSnapshot userdoc = await   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      username  = userdoc['username'];
    
    });
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
    title:const Text("Enter Code"),
    content:const Text("Enter Correct Code or Create Code"),
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
  joiningmeeting() async
  {   
    try
    {
      Map<FeatureFlagEnum,bool> featureflags = 
      {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
      };
      if(Platform.isAndroid)
      {
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
      else if(Platform.isIOS)
      {
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
      var options = JitsiMeetingOptions(
        room: roomcontroller.text,
      )
       ..userDisplayName = namecontroller.text == '' ? username : namecontroller.text
       ..audioMuted = isaudiomuted
       ..videoMuted = isvideomuted
       ..featureFlags.addAll(featureflags);
       
        await JitsiMeet.joinMeeting(options);
       
    }
    catch(e)
    {   
       print('Error : $e');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
            const  SizedBox(height: 24,),
              Text("Room Code",
              style: myStyle(20),),
              const SizedBox(height: 20,),
              PinCodeTextField(appContext: context,
               length: 6,
               controller: roomcontroller,
               autoDisposeControllers: false,
               animationType: AnimationType.fade,
               pinTheme: PinTheme(
                 shape: PinCodeFieldShape.underline,
               ),
               animationDuration:const Duration(milliseconds: 300),
               onChanged: (value)
               {
                 
               }),
             const SizedBox(height: 10,),
             TextField(
               controller: namecontroller,
               style: myStyle(20),
               decoration: InputDecoration(
                 border: const OutlineInputBorder(),
                 labelText: "Name (Leave if u want username)",
                 labelStyle: myStyle(15),
               ),
             ),
              const SizedBox(height: 16,),
              CheckboxListTile(
                value: isvideomuted,
                onChanged: (value)
                {
                  setState(() {
                    isvideomuted = value!;
                  });
                },
                title: Text('Video Muted',
                style: myStyle(18,Colors.black),
                 ),
                ),
              const SizedBox(height: 16,),
              CheckboxListTile(
                value: isaudiomuted,
                onChanged: (value)
                {
                  setState(() {
                    isaudiomuted = value!;
                  });
                },
                title: Text('Audio Muted',
                style: myStyle(18,Colors.black),
                 ),
                ),
                const SizedBox(height: 20,),
                Text('Of Course , you can customize settings in the meeting',
                style: myStyle(15),
                textAlign: TextAlign.center,
                ),
            const    Divider(thickness: 2.0,
                     height: 48,),
                InkWell(
            onTap: ()
                 {
                
                  joiningmeeting();
                         
                 },
            child: Container(
              width: double.maxFinite,
              height: 64,
              decoration:const BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                child: Text("Join Meeting",
                style: myStyle(20,Colors.white),),
              ),
            ),
          )
          ],
          ),
        ),
      ),
    );
  }
}