import 'package:chuss/Customer-side/ProfileScreen/components/profile_menu.dart';
import 'package:chuss/Customer-side/ProfileScreen/components/profile_pic.dart';
import 'package:chuss/components/loginmain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Body extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 50),
          ProfilePic(),
          SizedBox(height: 50),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/user.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/notification.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Share CHUSS",
            icon: "assets/icons/share.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "LogOut",
            icon: "assets/icons/exit.svg",
            press: () {
              signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginMain(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
