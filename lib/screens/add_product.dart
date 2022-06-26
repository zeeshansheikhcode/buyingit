/**
 * This File Contain the 
 * Form of Product
 * AlertDialogBoxes
 * DeviceInformation Function
 * Picking & Saving Product function
 */
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exif/exif.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import '../model_provider/products.dart';
import '../model_provider/products_model.dart';
import 'home_screen.dart';
class AddProduct extends StatefulWidget {
  final String title;
  final String createrIDvalue;
  final String sellby;
 static const routeName = '/add_product';
  const AddProduct({Key? key,required this.title, required this.createrIDvalue,required this.sellby}) : super(key: key);
  @override 
  State<AddProduct> createState() => _AddProductState();
}
class _AddProductState extends State<AddProduct> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin(); // Device Info Plugin
  Map<String, dynamic> _deviceData = <String, dynamic>{}; //Device data in Map From
   @override
  void initState() {
    super.initState();
    initPlatformState();            // Getting Device information in the start
  }
   File? _pickedImage;              // File for Pick Image
   String? productId;               // Product Id
   var storageImage;                // Variable to Store Image Path
   bool _isLoading =false;          // Showing Circuler Indicator
   var _isInit = true;              // Checking Iteration
   String? imageUrl;                // Image URL
   bool _pickingNormal = true;      // Selecting Normal Or 360 Image
   static int count=0;              // Keeping Picture Count
   final Uuid _uuid =const  Uuid(); // Generating Variable IDs
   String productname ='';          // Product Name for 360 Image
   String picname ='';              // Picture Name for 360 Image
   String foldername = '';          // Folder Name for 360 Image
   final _formkey = GlobalKey<FormState>(); // Generating Form Key
   var _initValues = {              // Getting Inital Form Values
    'id': '',
    'title': '',
    'price': '',
    'quantity': '',
    'description': '',
    'productImage': '',
    'category':'',
    'CreatorID':'',
    'seller':'',
  };
   var _editedProduct = Product( // Getting Edited Form Values
    id: '0' ,
    title: '',
    price: 0,
    quantity : 0,
    description: '', 
    productImage: '',
    category: '',
    CreatorID: '',
    seller: '',
  );
  //Call Start of Activity
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInit)
    {
       productId = ModalRoute.of(context)!.settings.arguments as dynamic;
       if (productId != null) 
       {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId!);
        _initValues = 
        {
          'id'              : _editedProduct.id,
          'title'           : _editedProduct.title,
          'price'           : _editedProduct.price.toString(),
          'quantity'        : _editedProduct.quantity.toString(),
          'description'     : _editedProduct.description,
          'productImage'    : _editedProduct.productImage,
          'category'        : _editedProduct.category, 
          'CreatorID'       : _editedProduct.CreatorID,
          'seller'          : _editedProduct.seller,
        };
      }
      _isInit=false;
    }
  }
  // Dialog Box to Show Copyright Error
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
    title:const Text("Copyright"),
    content:const Text("This image has a copyright issue"),
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
// Dialog Box to Show empty image Error
showAlertDialogforEmptyImage(BuildContext context)
{
  Widget okButton = TextButton(
    child:const Text("OK"),
    onPressed: () 
    {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title:const Text("Product Image"),
    content:const Text("Please Upload Image"),
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
//Getting Device Information
Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
      if (kIsWeb) {
       // deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
         // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          //deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          //deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          //deviceData =
            //  _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }
  //Getting Android Platform Information
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
       'brand'       : build.brand,
       'device'      : build.device,
       'id'          : build.id,
       'manufacturer': build.manufacturer,
       'model'       : build.model,
       'product'     : build.product,
       'androidId'   : build.androidId,
    };
  }
  //Picking Single Normal Image
  void _pickNormalImage() async {
    final picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.camera,
    imageQuality: 100,
    maxWidth: 150
    );
    setState(() {
      print('picking');
      _pickedImage = File(pickedImageFile!.path);
    });    
    storageImage = FirebaseStorage.instance.ref()
                   .child('UserImages').child(_uuid.v4().substring(0,5) + '.jpg');
                   print(storageImage);
  }
  Future getImagefromGallery() async {
    final picker = ImagePicker();
    final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.gallery,
    imageQuality: 100,
    maxWidth: 150
    );
    final fileBytes = File(pickedImageFile!.path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);
    if (data.isEmpty) {
      return;
    }
    if(_deviceData['model']==data['Image Model'].toString())
    {
      setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    }
    else{   
     setState((){
      _pickedImage = null;
      showAlertDialog(context);
      });
    } 
  }
   //Saving Normal Photo
    void _saveNormalPhoto() async
      {
        final isValid = _formkey.currentState!.validate();
        if (!isValid) 
           {
               return;
           }
        if (_pickedImage==null && productId==null) 
           {
             showAlertDialogforEmptyImage(context);
             return;
           }
        
           _formkey.currentState!.save();
           setState(() {
             _isLoading = true;
           });
           if (_editedProduct.id == '0') 
           {
             await storageImage.putFile(File(_pickedImage!.path));
             imageUrl = await storageImage.getDownloadURL();
               _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      seller      : widget.sellby,
                      productImage: imageUrl!,
                      CreatorID   : widget.createrIDvalue,
                      category    : widget.title,
                      );
           } 
          else
            {            
               _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: _editedProduct.productImage,
                      CreatorID   : _editedProduct.CreatorID,
                      category    : _editedProduct.category,
                      seller      : _editedProduct.seller ,     
                 ); 
             }   
           setState(() {
             _isLoading = false;
           });          
          if (_editedProduct.id != '0') 
           { 
               Provider.of<Products>(context, listen: false)
              .updateProduct(_editedProduct.id, _editedProduct);
               Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
               return;
            } 
        Provider.of<Products>(context, listen: false)
       .addproducts(_editedProduct);
       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
       return;
  }
  //Picking Multilple Images
    Future<void> _pickThreeDImage() async
   { if(count<=5)
     {
        final picker = ImagePicker();
        final XFile? pickedImageFile = await picker.pickImage(source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 150
        );
          if(count==0)
          {
            picname = _uuid.v4().substring(0,5);
            foldername = widget.createrIDvalue+'_'+picname;
          }
            setState(()
            {
             _pickedImage = File(pickedImageFile!.path);
              count++;
            });
            if(count==1)
            {
               _pickingNormal = false;
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(picname+ '.jpg');
              storageImage.putFile(File(_pickedImage!.path));  
              await storageImage.putFile(File(_pickedImage!.path)); 
            }
            if(count>1 && count<5)
            {
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(_uuid.v4().substring(0,5) + '.jpg');
              await storageImage.putFile(File(_pickedImage!.path)); 
              
            }
            if(count==5)
            {
              storageImage = FirebaseStorage.instance.ref()
              .child(foldername).child(_uuid.v4().substring(0,5) + '.jpg');
            }
     }    
  } 
    //Saving 360 Images
      void _saveThreeDPhoto() async
      {
            final isValid = _formkey.currentState!.validate();
              if (!isValid) 
                   {
                    return;
                   }
            if (_pickedImage==null && productId==null) 
           {
             showAlertDialogforEmptyImage(context);
             return;
           }
                   _formkey.currentState!.save();
                   setState(() {
                     _isLoading = true;
                   });
          if(_editedProduct.id == '0')
                {
                  await storageImage.putFile(File(_pickedImage!.path)); 
                  imageUrl = await storageImage.getDownloadURL();
                  _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      seller      : widget.sellby,
                      productImage: imageUrl!,
                      CreatorID   : widget.createrIDvalue,
                      category    : widget.title,
                      );
                }      
                else
                {
                      _editedProduct = Product(
                      id          : _editedProduct.id,
                      title       : _editedProduct.title,
                      price       : _editedProduct.price,
                      quantity    : _editedProduct.quantity,
                      description : _editedProduct.description,
                      productImage: _editedProduct.productImage,
                      CreatorID   : _editedProduct.CreatorID,
                      category    : _editedProduct.category, 
                      seller      : _editedProduct.seller ,    
                 );
                } 
                 setState(() {
                     _isLoading = false;
                   });  
          if (_editedProduct.id != '0') 
           { 
             Provider.of<Products>(context, listen: false)
            .updateProduct(_editedProduct.id, _editedProduct);
             Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
               return;
           } 
       Provider.of<Products>(context, listen: false)
      .addproducts(_editedProduct);
       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);  
       return; 
   }
 
  @override
  Widget build(BuildContext context) {
   
    return LayoutBuilder(builder: (context,constraints)
    {
      return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title:  Text(productId!=null ? 'Update' : widget.title,
        style:const TextStyle(fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon:const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: _pickingNormal ? _saveNormalPhoto : _saveThreeDPhoto, 
          icon: const Icon(Icons.save))
        ],    
      ),
      body: _isLoading == true
             ?
             const Center(child : CircularProgressIndicator())
             :
          SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>
            [
               SizedBox(height: constraints.maxHeight*0.01,),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                color: Colors.black,
                child: Container(
                  margin:  const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  height:(MediaQuery.of(context).size.height -
                             // appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) * 1.15,
                  width: double.infinity,
                  decoration:const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                            SizedBox(height: constraints.maxHeight*0.007,),
                           TextFormField(
                           initialValue: _initValues['title'],
                           decoration: InputDecoration(
                           labelText : 'Title' ,
                           hintText  : 'In English Ex. Jacket',
                           border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                           ),
                             validator: (value) {
                                if (value!.isEmpty)
                                 {
                                      return 'Please provide a value.';
                                 }
                                   return null;
                               },
                     onSaved: (value1) {
                    _editedProduct = Product(
                        title       : value1!,
                        price       : _editedProduct.price,
                        description : _editedProduct.description,
                        productImage: _editedProduct.productImage,
                        quantity    : _editedProduct.quantity,
                        id          : _editedProduct.id,
                        category    : _editedProduct.category,
                        CreatorID   : _editedProduct.CreatorID,
                         seller     : _editedProduct.seller ,
                        );
                       
                  },
        
                         ),
                          SizedBox(height: constraints.maxHeight*0.007,),
                          TextFormField(
                         
                         initialValue: _initValues['price'],
                          decoration: InputDecoration(
                          labelText : 'Price',
                          hintText  : 'In PKR Ex.10000',
                          border    : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                            ),
                          validator: (value) {
                            if (value!.isEmpty) {
                             return 'Please enter a price.';
                             }
                             if (double.tryParse(value) == null) {
                             return 'Please enter a valid number.';
                                  }
                             if (double.parse(value) <= 0) {
                             return 'Please enter a number greater than zero.';
                            }
                           return null;
                          },
                           onSaved: (value) {
                       _editedProduct = Product(
                        title        : _editedProduct.title,
                        price        : double.parse(value!),
                        quantity     : _editedProduct.quantity,
                        description  : _editedProduct.description,
                        productImage : _editedProduct.productImage,
                        id           : _editedProduct.id,
                        category     : _editedProduct.category,
                        CreatorID    : _editedProduct.CreatorID,
                         seller      : _editedProduct.seller ,
                        );
                  },
                          ),
                          SizedBox(height: constraints.maxHeight*0.007,),
                         TextFormField(
                         initialValue: _initValues['quantity'],
                         decoration : InputDecoration(
                         labelText  : 'Quantity' ,
                         hintText   : 'Number e.g.10,20',
                         border     : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                               ),
                            ),
                             validator: (value) {
                                if (value!.isEmpty)
                                 {
                                      return 'Please provide a value.';
                                 }
                                   return null;
                               },
                         onSaved: (value) {
                       _editedProduct = Product(
                        title        : _editedProduct.title,
                        price        : _editedProduct.price,
                        quantity     : double.parse(value!),
                        description  : _editedProduct.description,
                        productImage : _editedProduct.productImage,
                        id           : _editedProduct.id,
                        category     : _editedProduct.category,
                        CreatorID    : _editedProduct.CreatorID,
                         seller      : _editedProduct.seller ,
                        );
                     
                  },
                  ),
                         SizedBox(height: constraints.maxHeight*0.007,),
                        TextFormField(
                       // controller  : null,
                        initialValue: _initValues['description'],
                        keyboardType: TextInputType.multiline,  
                        decoration  : InputDecoration(
                        labelText   : 'Description' ,
                        hintText    : 'Max 20 to 25 Words', 
                        border      : OutlineInputBorder(borderRadius:BorderRadius.circular(10),
                              ),
                            ),
                   validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 15) {
                      return 'Should be at least 15 characters.';
                    }
                    return null;
                  },
                   onSaved: (value) {
                       _editedProduct = Product(
                        title       : _editedProduct.title,
                        price       : _editedProduct.price,
                        quantity    : _editedProduct.quantity,
                        description :  value!,
                        productImage: _editedProduct.productImage,
                        id          : _editedProduct.id,
                        category    : _editedProduct.category,
                        CreatorID   : _editedProduct.CreatorID,
                         seller     : _editedProduct.seller ,
                        );
                    
                  },
                ),
                       SizedBox(height: constraints.maxHeight*0.02,),
                       if(productId!=null)
                       Text('You cannot update image because of copyright issue',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                       SizedBox(height: constraints.maxHeight*0.02,),
                      
                      //  SizedBox(height: constraints.maxHeight*0.02,),
                       /**
                        *  Product is 360 
                        *  if Product Id not Null show Image of Product
                        *  OtherWise Show Image of assets Or Capture Picture
                        */
                       widget.title=='360 Product'
                       ?
                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            productId!=null
                               ?
                                 Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                NetworkImage(_editedProduct.productImage)
                                       ),
                                     ),
                   
                              )
                              :
                               _pickedImage == null
                                ?
                               Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.35,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:const Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                AssetImage('assets/images/product-placeholder.png'),
                                       ),
                                     ),
                              )
                              :
                              Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child:  Image.file(_pickedImage!)
                                     ),
                   
                            ),
                            /**
                             * Show Image Count of 360 
                             * Pic image from camere
                             * Pic image from copyright
                             * Also check Copy Right Issue
                             */
                  Card(
                       elevation: 4.0,
                       margin:  EdgeInsets.symmetric(
                         vertical:   constraints.maxHeight*0.01,
                         horizontal: constraints.maxWidth*0.01
                         ),
                       child: Container(
                        width:  constraints.maxWidth*0.4,
                        height: constraints.maxHeight*0.4,
                         decoration: const BoxDecoration(
                           color: Colors.white
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>
                           [
                              SizedBox(height: constraints.maxHeight*0.01),
                             const  Text('Take Photos',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                               ),
                              ),
                              SizedBox(height: constraints.maxHeight*0.01),
                               Column(
                                 children: [
                                   InkWell(
                                     onTap: count<=4 ? _pickThreeDImage : null,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.06,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.lightBlueAccent,
                                     ),
                                        child:  const Text('Camera',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                               SizedBox(height: constraints.maxHeight*0.01),
                                InkWell(
                                     onTap: count<=3 ? getImagefromGallery : null,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.06,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.blue,
                                     ),
                                        child:  const Text('Gallery',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                               SizedBox(height: constraints.maxHeight*0.01),
                               Container(
                               margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                 padding:  EdgeInsets.symmetric(
                                  vertical:    constraints.maxHeight*0.015,
                                  horizontal:  constraints.maxWidth*0.01,
                                 ),
                                 height: constraints.maxHeight*0.07,
                                 width: constraints.maxWidth*0.6,
                                 decoration:const  BoxDecoration(
                                   color: Colors.blueGrey,
                                 ),
                                    child:  
                                       Text('Total Photos $count',
                                     style: const TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                       color: Colors.white),
                                      ),  
                                 ),
                                  SizedBox(height: constraints.maxHeight*0.01),
                           
                                 ],
                               ),
                               
                           ],
                         ),      
                       ),
                     )
                  ])
                 :     
                  /**
                   *  Product is Normal Single Image
                   * if Product ID is not null show Product Image
                   * Otherwise Show assets or Capture Image from camera of Gallery 
                   */
                       Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              productId!=null && _pickedImage == null
                               ?
                                 Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.4,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child: Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                NetworkImage(_editedProduct.productImage)
                                       ),
                                     ),
                              )
                              :
                               _pickedImage == null
                                ?
                               Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.35,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:const Center( 
                                child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.grey,
                                backgroundImage: 
                                AssetImage('assets/images/product-placeholder.png'),
                                       ),
                                     ),
                              )
                              :
                              Container(
                                 width:  constraints.maxWidth*0.4,
                                 height: constraints.maxHeight*0.265,
                                 decoration:  BoxDecoration(
                                 color: Colors.white,
                                 border: Border.all(), 
                                   ),
                                child:  Center( 
                                child:  Image.file(_pickedImage!)
                                     ),
                            ),
                              /**
                             * Pic image from camere
                             * Pic image from copyright
                             * Also check Copy Right Issue
                             */
                  Card(
                       elevation: 4.0,
                       margin:  EdgeInsets.symmetric(
                         vertical:   constraints.maxHeight*0.01,
                         horizontal: constraints.maxWidth*0.01
                         ),
                       child: Container(
                        width:  constraints.maxWidth*0.4,
                        height: constraints.maxHeight*0.25,
                         decoration: const BoxDecoration(
                           color: Colors.white
                         ),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>
                           [
                              SizedBox(height: constraints.maxHeight*0.01),
                             const  Text('Take Photo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                               ),
                              ),
                              SizedBox(height: constraints.maxHeight*0.01), 
                               InkWell(
                               onTap: _pickNormalImage,
                               child: Container(
                                 margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                 height: constraints.maxHeight*0.07,
                                 width: constraints.maxWidth*0.4,
                                 padding:  EdgeInsets.symmetric(
                                  vertical:    constraints.maxHeight*0.015,
                                  horizontal:  constraints.maxWidth*0.08,
                                 ),
                                 decoration:const  BoxDecoration(
                                   color: Colors.lightBlueAccent,
                                 ),
                                 child:const Text('Camera', 
                                 style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white),
                                  ),
                                 ),
                               ),
                               SizedBox(height: constraints.maxHeight*0.01),
                                InkWell(
                                     onTap:  getImagefromGallery,
                                     child: Container(
                                     margin: EdgeInsets.symmetric(horizontal:constraints.maxWidth*0.01,),
                                     padding:  EdgeInsets.symmetric(
                                     vertical:    constraints.maxHeight*0.015,
                                     horizontal:  constraints.maxWidth*0.08,
                                     ),
                                     height: constraints.maxHeight*0.07,
                                     width: constraints.maxWidth*0.6,
                                     decoration:const  BoxDecoration(
                                       color: Colors.blue,
                                     ),
                                        child:  const Text('Gallery',
                                         style: TextStyle(
                                           fontWeight: FontWeight.bold,
                                           fontSize: 20,
                                           color: Colors.white),
                                          ), 
                                     ),
                                   ),
                             ],
                            ),  
                         ),      
                       ),
                   ],
                 ),
               ],
              ),
            ),
          ),
        )
            ]
          )
        )
      
        );
             
      
             } 
        );
    
    }
   }

       