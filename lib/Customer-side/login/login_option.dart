import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [

        Center(
          child: Text(
            "Login As a Customer ?",
            style: TextStyle(
              fontSize: 20,
              color:Color(0xFF1C1C1C),
              fontWeight: FontWeight.bold,
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
