import 'package:flutter/material.dart';

class SignUpOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [

        Center(
          child: Text(
                "Login As Technician \n or \nRegister ",
            style: TextStyle(
              fontSize: 20,
              color: Colors.yellowAccent[700],
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}