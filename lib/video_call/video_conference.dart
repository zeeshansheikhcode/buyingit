/**
 * This File contain Tab View For join and create meeting
 */
import 'package:flutter/material.dart';
import 'create_meeting.dart';
import 'joinmeeting.dart';

class VideoConference extends StatefulWidget {
  const VideoConference({ Key? key }) : super(key: key);

  @override
  _VideoConferenceState createState() => _VideoConferenceState();
}

class _VideoConferenceState extends State<VideoConference> with SingleTickerProviderStateMixin
{ TabController? tabController;
   buildTabs(String name)
   {
     return Container(
       height: 60,
       width: 150,
       child: Card(
         child: Center(
           child: Text(name,style:const  TextStyle(
             fontSize: 15,
             color: Colors.black,
             fontWeight:FontWeight.w700),
             ),
         ),
       ),
     );
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title:const Text("Video Call", style: TextStyle(fontSize:20,color: Colors.white, fontWeight:FontWeight.w700),
       ),
       centerTitle: true,
       backgroundColor: Colors.blue,
       bottom: TabBar(
         controller: tabController,
         tabs: [
           buildTabs("Join Meeting"),
           buildTabs("Create Meeting"),
         ],
         ),
     ),   
     body: TabBarView(
       controller: tabController,
       children:const [
         JoinMeeting(),
         CreateMeeting(),
       ],),   
    );
  }
}