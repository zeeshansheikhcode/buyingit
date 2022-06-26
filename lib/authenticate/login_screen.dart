/**
 * This File contains all Login GUI of User
 */
import 'package:buying_final/authenticate/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model_provider/auth.dart';
import '../screens/home_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);
  static const routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // A Login Screen 
  String?  _email;
  String?  _password;
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _islogin = true;
  final appBar = AppBar(
        title:const Text('Login',
         style: TextStyle(
           fontSize: 26,
           fontWeight: FontWeight.bold,
           ),
         ),
         centerTitle: true,   
      );
  showlogAlertDialog(BuildContext context,String errorMessage)
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
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return  LayoutBuilder(builder: (context,constraints)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
       appBar:appBar, 
       body: _isLoading 
             ?
             const Center(child:CircularProgressIndicator())
             :
          SingleChildScrollView(

            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height:    (
                                MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top ) * 0.9,        
                    width:  constraints.maxWidth*1.0,
                    margin:   EdgeInsets.symmetric(
                      vertical: constraints.maxHeight*0.01,
                      horizontal: constraints.maxWidth*0.01
                    ), 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: 
                      [  
                       SizedBox(height: constraints.maxHeight*0.01,),
                       TextFormField(
                      
                       decoration: InputDecoration(
                       labelText: 'Email' ,
                       hintText:  'Enter Email',
                       border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
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
                      SizedBox(height: constraints.maxHeight*0.01,),
                      TextFormField(
                     
                      decoration: InputDecoration(
                      labelText: 'Password' ,
                      hintText:  'Enter Password',   
                      border: OutlineInputBorder(borderRadius:BorderRadius.circular(10),
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
                     SizedBox(height: constraints.maxHeight*0.03,),
                    Container(
                         margin:  EdgeInsets.only(
                           bottom:constraints.maxHeight*0.01,
                           left: constraints.maxWidth*0.01,
                           right:constraints.maxWidth*0.01,
                           ),
                        height: constraints.maxHeight*0.1,
                        width: constraints.maxWidth*0.55,
                       decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                                     ),
                       child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                       primary: Colors.white, // background
                     onPrimary: Colors.black, // foreground
                                ),
                        onPressed: () async {
                           final isValid = _formkey.currentState!.validate();
                           if (!isValid) 
                      {
                       return;
                      }
             _formkey.currentState!.save();
              setState(() 
              {
               _isLoading = true;
              });
              _islogin = await  auth.logIn(_email!,_password!);
              if(_islogin == true)
              {
                setState(() {
               _isLoading = false;
                });                     
               Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);       
               }
              else
              {
                 setState(() {
                _isLoading = false;
                }); 
                 showlogAlertDialog(context,auth.errorMessage);
               }
            },
                        child: const Text('Login',
                        style: TextStyle(
                           fontSize: 22,  
                           ),
                          ),
                        ),
                      ),
                     
                     Container(
                      height: constraints.maxHeight*0.1,
                      width: constraints.maxWidth*0.55,
                       margin:  EdgeInsets.only(
                           bottom:constraints.maxHeight*0.01,
                           left: constraints.maxWidth*0.01,
                           right:constraints.maxWidth*0.01,
                           ),
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlueAccent,
                      ),
                       child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                       primary: Colors.white, // background
                     onPrimary: Colors.black, // foreground
                                ),
                       onPressed:(){
                       Navigator.of(context).push(MaterialPageRoute(
                       builder: (_)=>const SignUpScreen()));
                      },
                      child: const Text('Create Account',
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
          ),
    );
    });
    
  }
}