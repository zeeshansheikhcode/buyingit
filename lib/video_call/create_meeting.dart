/**
 * This File contain Creating Code Function to invite and join meeting
 */
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:uuid/uuid.dart';
import '../widget/variables.dart';
class CreateMeeting extends StatefulWidget {
  const CreateMeeting({ Key? key }) : super(key: key);

  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code= ''; // Code For Meeting
  createcode()
  {
    setState(() {
      code = Uuid().v1().substring(0,6);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text('Create a Code and share it with your friend',
            style: myStyle(20),
            textAlign: TextAlign.center,),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: 
            [
              Text("Code:", style: myStyle(30),),
              Text(code, style: myStyle(30,Colors.purple,FontWeight.w700),),
            ],
          ),
          SizedBox(height: 25,),
          InkWell(
            onTap: ()=>createcode(),
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              decoration:const BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                child: Text("Create Code",
                style: myStyle(20,Colors.white),),
              ),
            ),
          )
        ],
      ),
      
    );
  }
}