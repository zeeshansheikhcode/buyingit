/**
 * This File Show 360 View of Product in Seconds
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import '../video_call/video_conference.dart';
import '../screens/detail_chatsearch.dart';
class ThreeDImages extends StatefulWidget {
  final String id;
  final double price;
  final String image;
  final String desc;
  final String title;
  final String owner;
  const ThreeDImages({ Key? key,
  required this.id,
  required this.price,
  required this.image, 
  required this.desc,
  required this.title,
  required this.owner 
  }) : super(key: key);
  @override
  _ThreeDImagesState createState() => _ThreeDImagesState();
}

class _ThreeDImagesState extends State<ThreeDImages> {
  int pic_count =0;
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 50);
  bool imagePrecached = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  @override
  void initState() {
    _loadImages(context);
        super.initState();
  }
   String? userId;
  Future<void> _loadImages(BuildContext context) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      userId = _auth.currentUser!.uid;
      String linkfolder = widget.image;
      linkfolder = linkfolder.split("/")[7];
      linkfolder = linkfolder.replaceAll("%20"," ");
      linkfolder = linkfolder.substring(0, linkfolder.indexOf('%2F'));
      final ListResult result = await storage.ref().child(linkfolder).list();
      final List<Reference> allFiles = result.items;
      await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      String link = fileUrl;
      link = link.split("/")[7];
      link = link.replaceAll("%20"," ");
      link = link.replaceAll("%2F", "/");
      link = link.substring(0, link.indexOf('.jpg'));
      imageList.add(FirebaseImage('gs://buyingfinal-e8c0d.appspot.com/$link.jpg'));
      pic_count = imageList.length;
    });
    updateImageList(context);
  }
void updateImageList(BuildContext context) async {
   for (int i = 0; i<imageList.length; i++) {  
       imageList[i].toString();
       await precacheImage(imageList[i], context);
   }
    setState(() {
      imagePrecached = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraint)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [   SizedBox(height: constraint.maxHeight*0.03,),
              Container(
                 height:(
                            MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top ) * 0.5,
                 width: double.infinity,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                 ),
                  child: (imagePrecached == true)
                    ?  ImageView360(
                          key: UniqueKey(),
                          imageList: imageList,
                          autoRotate: autoRotate,
                          rotationCount: rotationCount,
                          rotationDirection: RotationDirection.anticlockwise,
                          frameChangeDuration:const Duration(seconds: 3),
                          swipeSensitivity: swipeSensitivity,
                          allowSwipeToRotate: allowSwipeToRotate,
                          onImageIndexChanged: (currentImageIndex) {},
                        )
                    : 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                           Text("Loading Images Please Wait"),
                           SizedBox(height: 15,),
                           CircularProgressIndicator(),
                      ],
                    ),
              ),
              SizedBox(height: constraint.maxHeight*0.001), 
              Card(  
              margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.005,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>
                [
                  Container(
                  margin:  EdgeInsets.symmetric(
                    horizontal: constraint.maxWidth*0.02,
                    vertical: constraint.maxHeight*0.01),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                     const  Text(' Price: ',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                       color: Colors.black,
                        ),
                       ),
                      SizedBox(width:  constraint.maxWidth*0.2,),
                       Text(widget.price.toString().length>10 
                             ?
                             widget.price.toString().substring(0,9)
                             :
                             widget.price.toString(),
                       style:const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),
                Container(
                  margin:  EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxWidth*0.02,
                  ),
                  height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                    [  
                      const Text(' Description: ',
                       style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 16,
                       color: Colors.black,
                        ),
                       ),
                     const SizedBox(width: 10,),
                       Text(
                          widget.desc.length >=40 
                          ?
                          widget.desc.substring(0,30)
                          :
                          widget.desc,
                       style:const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 15,
                       color: Colors.black,
                        ),
                       ),
                    ],
                  ),
                ),     
                ] 
              ),
            ),
            SizedBox(height: constraint.maxHeight*0.01,),
             Card(  
             margin:  EdgeInsets.symmetric(
                vertical: constraint.maxHeight*0.0001,
                horizontal: constraint.maxWidth*0.02,
              ),
              color: Colors.white,
              elevation: 4,
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: constraint.maxHeight*0.01,
                    horizontal: constraint.maxHeight*0.01,
                  ),
                   height: constraint.maxHeight * 0.07,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                     [  
                      Card(
                        child: InkWell(
                          onTap:()
                           {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> const VideoConference()));
                         },
                          child: Container(
                            padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.04,
                               vertical: constraint.maxHeight*0.01,
                               ),
                                height: constraint.maxHeight * 0.07,
                              width: constraint.maxWidth*0.4,
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
                     Card(
                       child: InkWell(
                         onTap: ()
                         {
                            Navigator.push(context, MaterialPageRoute(builder: 
                           (context)=>  DetailChat(sellername: widget.owner,)));
                        
                          
                         },
                          child: Container(
                              padding:  EdgeInsets.symmetric(
                               horizontal:constraint.maxWidth*0.06,
                               vertical: constraint.maxHeight*0.01,
                               ),
                              height: constraint.maxHeight * 0.07,
                              width: constraint.maxWidth*0.4,
                              decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const Text('Chat',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                          ),
                        ),
                     ),
                    ],
                  ),
                ),
              ),
            ), 
           ],
        ),
       )
      );
 
    });
  }
}
  
 
