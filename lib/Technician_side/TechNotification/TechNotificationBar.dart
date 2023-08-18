import 'package:flutter/material.dart';

class TechNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Text(
      'No Notifications Yet',
      style: TextStyle(color: Theme.of(context).accentColor),
    ),
        ));
  }
}
