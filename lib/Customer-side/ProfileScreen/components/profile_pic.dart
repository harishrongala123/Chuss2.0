import 'dart:io';
import 'package:chuss/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  PickedFile _imagefile;

  final ImagePicker _picker = ImagePicker();
  Future TakePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imagefile = pickedFile;
    });
  }

  Future uploadPic (BuildContext context) async {
    String filename = basename(_imagefile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref('uploads/TechnicianProfilePic/').child(filename);
    UploadTask uploadTask = firebaseStorageRef.putFile(File(_imagefile.path));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {
      String loc = await firebaseStorageRef.getDownloadURL();
      return loc;
    });

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                child: (_imagefile!=null)?Image.file(File(_imagefile.path),fit: BoxFit.cover,)
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
                                  TakePhoto(ImageSource.camera);
                                },style:ElevatedButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                  elevation: 0,
                                ),
                                    icon: Icon(Icons.camera,color: PrimaryYellow,),
                                    label: Text("Camera",style: TextStyle(color: Theme.of(context).accentColor),)
                                ),

                                ElevatedButton.icon(onPressed: (){
                                  TakePhoto(ImageSource.gallery);
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

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25)
                                ),
                                primary: Colors.black,
                              ),
                              onPressed: (){
                                uploadPic(context);
                              },
                                child:
                                Text("Submit",
                                  style: TextStyle(
                                    color: PrimaryYellow,
                                  ),
                                ),

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
    );
  }
}
