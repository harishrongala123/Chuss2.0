import 'package:chuss/Technician_side/TechHome/Components/TechNavigationBar.dart';
import 'package:chuss/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pin_put/pin_put.dart';

class TechVerification extends StatefulWidget {
  final String phone;
  final String uname;
  TechVerification(this.phone,this.uname);
  @override
  _TechVerificationState createState() => _TechVerificationState();
}

class _TechVerificationState extends State<TechVerification> {
  String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1.0),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP VERIFICATION'),
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
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
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
                          MaterialPageRoute(builder:(context) => TechNavigationBar()),
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
  _verifyphone()async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:'+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async{
            if(value.user!=null){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder:(context) => TechNavigationBar()),
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
