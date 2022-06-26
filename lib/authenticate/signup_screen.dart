/**
 * This File contains all Sign Up GUI of User
 */
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../model_provider/auth.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
class SignUpScreen extends StatefulWidget {
    static const routeName = '/signup';
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //A Sign Up Screen
  String?  _name;
  String?  _email;
  String?  _password;
  String?  _phonenum;
  bool _isSignUp =true;
  final _formkey = GlobalKey<FormState>();
  var storageImage ;
  File? _pickedImage;
  final Uuid _uuid =const  Uuid();
  String? imageUrl;
  showAlertDialog(BuildContext context)
{       Widget okButton = TextButton(
        child:const Text("OK"),
        onPressed: () 
         {
          Navigator.pop(context);
          },
         );
        AlertDialog alert = AlertDialog(
        title:const Text("Take Picture"),
        content:const Text("Please Register With Profile Picture"),
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
    showSigninAlertDialog(BuildContext context,String errorMessage)
{
  Widget okButton = TextButton(
    child:const Text("OK"),
    onPressed: () 
    {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("Error in Credentials"),
    content: Text(errorMessage),
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
  void _pickUserImage() async {
    final picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.camera,
    imageQuality: 100,
    maxWidth: 150
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });    
    storageImage = FirebaseStorage.instance.ref()
                   .child('ProfileImages').child(_uuid.v4().substring(0,5) + '.jpg');
     await storageImage.putFile(File(_pickedImage!.path));
     imageUrl = await storageImage.getDownloadURL();
  }
  bool _isLoading = false;
  final appBar = AppBar(
        title:const Text('Sign Up',
         style: TextStyle(
           fontSize: 26,
           fontWeight: FontWeight.bold,
           ),
         ),
         centerTitle: true,   
      );
  
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return LayoutBuilder(builder: (context,constraints)
    {
       return Scaffold(
      backgroundColor: Colors.white,
     // appBar: AppBar(),
      appBar: appBar,
      body: _isLoading 
           ?
           const Center(child: CircularProgressIndicator(),)
           :
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height:  (
                            MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top ) * 1.2,
                  width:  double.infinity,
                  margin:  const EdgeInsets.all(10), 
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey,
                                    backgroundImage:
                                      _pickedImage != null ? FileImage(_pickedImage!) : null,
                                      ),
                                  FlatButton.icon(
                                  textColor: Theme.of(context).primaryColor,
                                  onPressed: _pickUserImage,
                                  icon:const Icon(Icons.image,color: Colors.black,),
                                  label: const Text('Add Image' ,style: TextStyle(color: Colors.black),
                                  ),
                              ),
                              
                               SizedBox(height: constraints.maxHeight*0.007,),
                               TextFormField(
                               decoration: InputDecoration(
                               labelText : 'Name' ,
                               hintText  : 'Enter Name',
                               border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                                  ),
                               ),
                                 validator: (value) {
                                    if (value!.isEmpty)
                                     {
                                          return 'Please enter name.';
                                     }
                                       return null;
                                   },
                                   onSaved: (value)
                                   {
                                      _name = value;
                                   },
                             ),
                              SizedBox(height: constraints.maxHeight*0.007,),
                              TextFormField(
                              decoration: InputDecoration(
                              labelText : 'Phone Number',
                              hintText  : 'Enter Phone Number',
                              border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                                  ),
                                ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                 return 'Please enter your phone number.';
                                }
                               return null;
                              },
                                onSaved: (value)
                                   {
                                      _phonenum = value;
                                   },
                             
                              ),
                              SizedBox(height: constraints.maxHeight*0.007,),
                             TextFormField(
                             decoration : InputDecoration(
                             labelText  : 'Email' ,
                             hintText   : 'Enter Email',
                             border     : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                                   ),
                                ),
                                 validator: (value) {
                                    if (value!.isEmpty)
                                     {
                                          return 'Please enter email.';
                                     }
                                     if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value))
                                       {
                                         return 'Please enter valid email.';
                                       }
                                       return null;
                                   },
                                     onSaved: (value)
                                   {
                                      _email = value;
                                   },
                           
                      ),
                             SizedBox(height: constraints.maxHeight*0.007,),
                            TextFormField(  
                            decoration  : InputDecoration(
                            labelText   : 'Password' ,
                            hintText    : 'Enter Password', 
                            border      : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                                  ),
                                ),
                       validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password.';
                        }
                        if (value.length < 7) {
                          return 'Should be at least 7 characters long.';
                        }
                        return null;
                      },
                        onSaved: (value)
                                   {
                                      _password = value;
                                   },
                ),
                 SizedBox(height: constraints.maxHeight*0.005,),
                      Container(
                      margin: const EdgeInsets.only(bottom:10,left: 10,right: 10),
                      height: constraints.maxHeight*0.07,
                      width: constraints.maxWidth*0.5,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:const Color.fromARGB(255, 82, 85, 90),
                      ),
       child: 
        ElevatedButton(
           style: ElevatedButton.styleFrom(
                       primary: Colors.white, // background
                 onPrimary: Colors.black, // foreground
                                ),
       onPressed: ()  async{
         final isValid = _formkey.currentState!.validate();
         if (!isValid) 
                       {
                           return;
                       }    
           if(imageUrl==null)
           {
              showAlertDialog(context); 
              return;        
           }
           else
           {
             _formkey.currentState!.save();
              setState(() {
             _isLoading = true;
              });
             _isSignUp =  await  auth.createAccount(_name!,_email!,_password!,_phonenum!,imageUrl!);
              if(_isSignUp==true)
               {
                  setState(() {
                 _isLoading = false;
                   });
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName); 
                // Navigator.push(context,MaterialPageRoute(builder:(context)=>const LoginScreen()));           
               }
              else
              {
                setState(() {
                _isLoading = false;
                }); 
                 showSigninAlertDialog(context,auth.errorMessage);

              } 
               }
         
      },
        child: const Text('Sign Up',
               style: TextStyle(
               fontSize: 22,  
                 ),
               ),
            ),
                ),
                 Container(
                      margin: const EdgeInsets.only(bottom:10,left: 10,right: 10),
                      height: constraints.maxHeight*0.07,
                      width: constraints.maxWidth*0.5,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                      child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                       primary: Colors.white, // background
                 onPrimary: Colors.black, // foreground
                                ),
                        onPressed: ()
                        {
                          Navigator.push((context),MaterialPageRoute(builder: (context)=> const LoginScreen()));
                        },
                        child: const Text('Cancel',
                        style: TextStyle(
                           fontSize: 22,  
                           ),
                          ),
                        ),
                ),
                           ]
                          ),
                ),
                    ],
                  ),    
                ),  
               ],
              ),
            ),
             );     
    });
  }  
}
   