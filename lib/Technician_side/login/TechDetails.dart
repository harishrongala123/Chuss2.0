import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:chuss/components/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'TechVerification.dart';

class TechDetails extends StatefulWidget {
  String username;
  String phone;
  String title;
  TechDetails(this.username,this.phone, this.title);

  @override
  _TechDetailsState createState() => _TechDetailsState();

}


class _TechDetailsState extends State<TechDetails> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _text = new TextEditingController();


  bool isPicAvail = false;
  PickedFile _imageFile;

  final ImagePicker _picker = ImagePicker();
  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      if(pickedFile != null) {
        isPicAvail = true;
        _imageFile = pickedFile;
      }
    });
  }

  Future uploadPic (BuildContext context) async {
    String title = widget.title;

    String filename = basename(_imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref('uploads/TechnicianProfilePic/${phoneController.text}').child(filename);
    UploadTask uploadTask = firebaseStorageRef.putFile(File(_imageFile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {
       String imagePath = await firebaseStorageRef.getDownloadURL();
       String uniqueCode ='+91'+ phoneController.text;
       DocumentReference reference = FirebaseFirestore
           .instance.doc('$title/' + uniqueCode);
       await FirebaseFirestore.instance.collection(title)
           .doc(phoneController.text)
           .get()
           .then((DocumentSnapshot documentSnapshot) {
         {
           Map <String, dynamic> data = {
             "username": usernameController.text,
             "phone": '+91'+ phoneController.text,
             "address": addressController.text,
             "email": _emailController.text,
             "description": _text.text,
             "Role": "Technician",
             "imageUrl": imagePath,
             "isTopPicked": true,
             "accVerified": true,
             'location': GeoPoint(techLatitude,techLongitude),
           };
           reference.set(data);
         }
       });
    });
  }

  double techLatitude;
  double techLongitude;
  String techAddress;
  String placeName;

  Future getCurrentAddress() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    this.techLatitude = _locationData.latitude;
    this.techLongitude = _locationData.longitude;

    final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    var _addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var techAddress = _addresses.first;
    this.techAddress = techAddress.addressLine;
    this.placeName = techAddress.featureName;
    return techAddress;
  }

  @override
  void initState() {
    usernameController = TextEditingController(text: widget.username);
    phoneController = TextEditingController(text: widget.phone);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),

                Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          child:ClipOval(
                            child: SizedBox(
                              height: 180.0,
                              width: 180.0,
                              child: (_imageFile!=null)?Image.file(File(_imageFile.path),fit: BoxFit.cover,)
                                  :Image.asset("assets/images/dp.png"),
                            ),
                          ),
                        ),
                        Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: ElevatedButton(
                                style:ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor,shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Theme.of(context).primaryColor),)
                                ),
                                onPressed: () {
                                  showModalBottomSheet(context: context,
                                      builder: (context){
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget> [
                                            Text(
                                              "Choose Profile Photo ",
                                              style: TextStyle(
                                                  color: Theme.of(context).accentColor,
                                                  fontSize: 18
                                              ),
                                            ),

                                            SizedBox(
                                              height: 20,
                                            ),

                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:<Widget> [
                                                ElevatedButton.icon(onPressed:() {
                                                  takePhoto(ImageSource.camera);
                                                },style:ElevatedButton.styleFrom(
                                                  primary: Theme.of(context).primaryColor,
                                                  elevation: 0,
                                                ),
                                                    icon: Icon(Icons.camera,color: PrimaryYellow,),
                                                    label: Text("Camera",style: TextStyle(color: Theme.of(context).accentColor),)
                                                ),

                                                ElevatedButton.icon(onPressed: (){
                                                  takePhoto(ImageSource.gallery);
                                                },style:ElevatedButton.styleFrom(
                                                  primary: Theme.of(context).primaryColor,
                                                  elevation: 0,
                                                ),
                                                    icon: Icon(Icons.image,color: PrimaryYellow,),
                                                    label:Text("Gallery",style: TextStyle(color: Theme.of(context).accentColor),)
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: SvgPicture.asset("assets/icons/camera.svg",color: PrimaryYellow,),

                              ),
                            ))
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 25,
                ),


                Center(
                  child: Text(
                      "Please fill to register as "+ widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).accentColor,
                        height: 1,
                      ),
                    ),
                ),

                SizedBox(
                  height: 25,
                ),


                ClayContainer(

                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value.isEmpty){
                        return'Enter your Name';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: InputDecoration(
                      labelText: "Username",

                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.person,color: PrimaryYellow,),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),

                      contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 0,),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if(value.isEmpty) {
                        return'Enter mobile number';
                      }
                      if(value.length != 10) {
                        return 'Enter correct Number';
                      }
                      setState(() {
                        phoneController.text = value;
                      });
                      return null;
                    },
                    style: TextStyle(color: Theme.of(context).accentColor,),
                    decoration: InputDecoration(
                      labelText: " PhoneNumber",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.phone,color: PrimaryYellow,),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),

                      contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 0,),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),

                ),

                SizedBox(
                  height: 20,
                ),

                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Enter Email';
                      }
                      final bool _isValid = EmailValidator.validate(_emailController.text);
                      if(!_isValid) {
                        return 'Invalid Email Format';
                      }
                      return null;
                    },
                    style: TextStyle(color: Theme.of(context).accentColor,),
                    decoration: InputDecoration(
                      labelText: " Email",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.mail,color: PrimaryYellow,),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),

                      contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 0,),
                    ),
                  ),

                ),

                SizedBox(
                  height: 20,
                ),


                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                    child: TextFormField(
                      maxLines: 6,
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (value.isEmpty){
                          return'please press Navigation Button';
                        }
                        if (techLatitude == null){
                          return'please press Navigation Button';
                        }
                        return null;
                      },
                      style: TextStyle(color: Theme.of(context).accentColor,),
                      decoration: InputDecoration(
                        labelText: " Address",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).accentColor,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.location_on_rounded,color: PrimaryYellow,) ,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(icon: Icon(Icons.location_searching_rounded,color: PrimaryYellow,),
                            onPressed: () {
                            addressController.text = 'please wait while we fetch your location ';
                            getCurrentAddress().then((address) {
                              if(address!= null){
                                setState(() {
                                  addressController.text = '$placeName \n $techAddress';
                                });
                              }
                            });
                            },
                          ),

                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),

                        contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 10,),
                      ),
                    ),
                ),

                SizedBox(
                  height: 20,
                ),

                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: _text,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    validator: (value) {
                      if (value.isEmpty){
                        return 'Enter your skills';
                      }
                      return null;
                    },
                    style: TextStyle(color: Theme.of(context).accentColor,),
                    decoration: InputDecoration(
                      labelText: " Tell About Your Skills",
                      labelStyle: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.text_fields,color: PrimaryYellow,),

                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding:EdgeInsets.symmetric(horizontal: 16, vertical: 0,),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 50,
                ),

                SizedBox(
                  width: 30,
                  child: ElevatedButton(
                    style:ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25),

                    ),
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      if (isPicAvail == true) {
                        if (_formKey.currentState.validate()) {
                          uploadPic(context);
                          FirebaseFirestore.instance.collection('UserData')
                              .doc('+91' + phoneController.text)
                              .update({
                            'Role': 'Technician',
                          }
                          );

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TechVerification(phoneController.text,usernameController.text)
                          ));
                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ProfilePic need to be uploaded'),));
                      }
                      },
                    child: Center(
                      child: Text('Register',style: TextStyle(color: PrimaryYellow),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
