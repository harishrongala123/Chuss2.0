import 'package:chuss/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
}) : super(key : key);

  final String text,icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          style:ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor,shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          ), onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: PrimaryYellow,
                width: 22,
              ),
              SizedBox(width: 30),
              Expanded(child: Text(text,
                style: TextStyle(
                color: Theme.of(context).accentColor,

              ),)),
              Icon(Icons.arrow_forward_ios,color: Theme.of(context).accentColor,),
            ],
          ),

        ),
      ),
    );
  }
}
