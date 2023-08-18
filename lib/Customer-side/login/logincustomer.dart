import 'package:chuss/components/constants.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chuss/Customer-side/login/verificationscreen.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController udata = TextEditingController();
  TextEditingController phdata = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         Padding(
           padding: const EdgeInsets.only(top: 40, bottom: 25),
           child: SizedBox(
               height: 100,
               width: 100,
               child: SvgPicture.asset("assets/icons/logo.svg")),
         ),

        Text(
        "Welcome to",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF1C1C1C),
          height: 2,
        ),
    ),

        Text(
          "CHUSS",
          style: TextStyle(
            fontSize: 36,
            color: Color(0xFF1C1C1C),
            height: 1,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),

        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
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
                color: PrimaryYellow,
                customBorderRadius: BorderRadius.circular(25),
                child: TextFormField(
                  controller: udata,
                  validator: (value) {
                    if (value.isEmpty){
                      return'Enter your Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: " UserName",
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1C1C1C),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.person,color: Colors.black,),
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
                height: 16,
              ),

              ClayContainer(
                color: Colors.yellowAccent[700],
                customBorderRadius: BorderRadius.circular(25),
                child: TextFormField(
                    controller: phdata,
                    validator: (value) {
                      if(value.isEmpty) {
                        return'Enter mobile number';
                      }
                      if(value.length != 10) {
                        return 'Enter correct Number';
                      }
                      setState(() {
                        phdata.text = value;
                      });
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "PhoneNumber",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1C1C1C),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.phone,color: Colors.black,),
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
                    inputFormatters:[
                      LengthLimitingTextInputFormatter(10),
                    ]
                ),
              ),
            ],
          )
        ),



        SizedBox(
          height: 24,
        ),

        ElevatedButton(
          style:ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25),
          ),
            primary: Colors.black,
          ),
          onPressed: () async {
            if(_formKey.currentState.validate()){
            String uniqueCode = '+91'+phdata.text;
            await FirebaseFirestore.instance.doc("UserData/$uniqueCode").get().then((doc) {
              if (doc.exists) {
                FirebaseFirestore.instance.collection('UserData')
                    .doc('+91' + phdata.text)
                    .update({
                  "UserName" :udata.text,
                  "PhoneNumber" :'+91'+ phdata.text,
                  'Role': 'Customer',
                }
                );
              }
              else{
                DocumentReference reference = FirebaseFirestore.instance.doc("UserData/"+uniqueCode);
                FirebaseFirestore.instance.collection("UserData")
                    .doc(phdata.text,)
                    .get()
                    .then((DocumentSnapshot documentSnapshot){
                  {
                    Map<String,dynamic> data = {
                      "UserName" :udata.text,
                      "PhoneNumber" :'+91'+phdata.text,
                      "Role": "Customer",
                    };
                    reference.set(data);
                  }
                });
              }
            });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>VerificationScreen(phdata.text,udata.text)
            ));
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
      ],
    );
  }
}
