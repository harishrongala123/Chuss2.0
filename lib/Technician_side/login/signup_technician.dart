import 'package:chuss/components/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TechDetails.dart';
import 'TechVerification.dart';
import 'components/Scrollbar.dart';
import 'customlistanimation.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

List <String> _list = ['Plumber','Carpenter','Electrician','Builder','Catering','Painter','Mechanic','Tailor','EventManager'];

class _SignupState extends State<Signup> {
  TextEditingController username = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String title = 'Select Service';
  bool isStrechedDropDown = false;
  int groupValue;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).accentColor,
            height: 2,
          ),
        ),
        Text(
          "CHUSS",
          style: TextStyle(
            fontSize: 36,
            color: Theme.of(context).accentColor,
            height: 1,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).accentColor,
            height: 1,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter your Name';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: InputDecoration(
                      labelText: " UserName",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.person,
                          color: PrimaryYellow,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ClayContainer(
                  color: Theme.of(context).primaryColor,
                  customBorderRadius: BorderRadius.circular(25),
                  child: TextFormField(
                    controller: phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter mobile number';
                      }
                      if (value.length != 10) {
                        return 'Enter correct Number';
                      }
                      setState(() {
                        phone.text = value;
                      });
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: InputDecoration(
                      labelText: "PhoneNumber",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.phone,
                          color: PrimaryYellow,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                ),
              ],
            )),
        SizedBox(
          height: 16,
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              isStrechedDropDown = !isStrechedDropDown;
            });
          },
          child: ClayContainer(
              color: Theme.of(context).primaryColor,
              customBorderRadius: BorderRadius.circular(25),
              child: Padding(
                padding: const EdgeInsets.all(10.5),
                child: Row(children: [
                  Expanded(child: Center(
                    child: Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  )
                  ),
                  Icon(isStrechedDropDown ? Icons.arrow_drop_up_sharp: Icons.arrow_drop_down_sharp,color: PrimaryYellow,),
                ],),
              )

          ),
        ),
        ExpandedSection(
          expand: isStrechedDropDown,height: 300,
          child: MyScrollbar(
            builder: (context,scrollController2 ) =>
                ListView.builder(
                    controller: scrollController2,
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (context,index){
                      return RadioListTile(
                          activeColor: Theme.of(context).accentColor,
                          title: Text(_list.elementAt(index),

                            style: TextStyle(
                              color: Theme.of(context).accentColor,

                            ),
                          ),
                          value: index,
                          groupValue: groupValue,
                          onChanged: (val) {
                            setState(() {
                              groupValue = val;
                              title = _list.elementAt(index);
                            });

                          });
                    }),
          ),
        ),

        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25),
            ),
            primary: Colors.black,
          ),
          onPressed: () async {
            String uniqueCode = '+91' + phone.text;
            if (_formKey.currentState.validate() && title != 'Select Service') {
              await FirebaseFirestore.instance
                  .doc("UserData/$uniqueCode")
                  .get()
                  .then((doc) {
                if (doc.exists) {
                  FirebaseFirestore.instance
                      .collection('UserData')
                      .doc('+91' + phone.text)
                      .update({
                    "UserName": username.text,
                    "PhoneNumber": '+91' + phone.text,
                    'Role': 'Technician',
                  });
                }
              });
              await FirebaseFirestore.instance
                  .doc('$title/$uniqueCode')
                  .get()
                  .then((doc) {
                if (doc.exists) {
                  FirebaseFirestore.instance
                      .collection('$title')
                      .doc('+91' + phone.text)
                      .update({
                    "UserName": username.text,
                    "PhoneNumber": phone.text,
                    'Role': 'Technician',
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TechVerification(phone.text,username.text)));
                } else {
                  DocumentReference reference = FirebaseFirestore.instance.doc("UserData/"+uniqueCode);
                  FirebaseFirestore.instance.collection("UserData")
                      .doc(phone.text)
                      .get()
                      .then((DocumentSnapshot documentSnapshot){
                    {
                      Map<String,dynamic> data = {
                        "UserName" :username.text,
                        "PhoneNumber" :'+91'+phone.text,
                        "Role": "Technician",
                      };
                      reference.set(data);
                    }
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TechDetails(username.text, phone.text,title.toString())));
                }
              });
            }else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Select your Service'),));
            }
          },
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent[700],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
