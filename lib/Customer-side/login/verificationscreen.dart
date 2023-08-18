import 'package:chuss/Customer-side/CustomerNav/CustomerNavigationbar.dart';
import 'package:chuss/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationScreen extends StatefulWidget {
  final String phone;
  final String uname;
  VerificationScreen(this.phone,this.uname);
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: PrimaryYellow
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: SvgPicture.asset(
                  "assets/icons/smartphone.svg",
                height: 150,
                width: 150,
                color: PrimaryYellow,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'Welcome ${widget.uname}',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,fontSize: 26),
              ),
            ),
          ),
        Container(
          child: Center(
            child: Text(
              'Verifying +91 ${widget.phone}',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: PinPut(
            fieldsCount: 6,
            withCursor: true,
            textStyle: TextStyle(
                fontSize: 25.0,
                color: Theme.of(context).accentColor,
            ),
            eachFieldWidth: 40.0,
            eachFieldHeight: 55.0,
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutDecoration,
            selectedFieldDecoration: pinPutDecoration,
            followingFieldDecoration: pinPutDecoration,
            pinAnimationType: PinAnimationType.fade,
            onSubmit: (pin) async {
              try{
                await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: pin)).then((value) async{
                  if(value.user != null){
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder:(context) => CustomerNavigationBar()),
                            (route) => false);
                  }
                });
              }catch(e){
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Invalid PIN')));
              }
            },
          ),
        )
      ],
      ),
    );

  }
  _verifyphone() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:'+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async{
            if(value.user!=null){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder:(context) => CustomerNavigationBar()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e){
          print(e.message);
        },
        codeSent: (String verificationID,int resendToken){
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID){
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyphone();
  }
}
