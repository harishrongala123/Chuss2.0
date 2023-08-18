import 'package:chuss/Customer-side/Bookings/Bookings.dart';
import 'package:chuss/Customer-side/Home/homepage.dart';
import 'package:chuss/Customer-side/Notifications/NotificationScreen.dart';
import 'package:chuss/Customer-side/ProfileScreen/profile_screen.dart';
import 'package:chuss/components/constants.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomerNavigationBar extends StatefulWidget {
  @override
  _CustomerNavigationBarState createState() => _CustomerNavigationBarState();
}

class _CustomerNavigationBarState extends State<CustomerNavigationBar> {
  int currentIndex = 0;
  PageController _pageController;

  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 10;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: ClayContainer(
          color: Theme.of(context).primaryColor,
          child: Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(100)),

            ),
            child: GNav(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 300),

                tabs: [

                  GButton(
                    icon: CupertinoIcons.home,
                    text: 'Home',
                    iconColor: Theme.of(context).accentColor,
                    iconActiveColor: PrimaryYellow,
                    iconSize: 24,
                    textColor: Theme.of(context).accentColor,
                    padding: padding,
                    gap: gap,
                  ),

                  GButton(
                    icon: CupertinoIcons.square_list,
                    text: 'Bookings',
                    iconColor: Theme.of(context).accentColor,
                    iconActiveColor: PrimaryYellow,
                    iconSize: 24,
                    textColor: Theme.of(context).accentColor,
                    padding: padding,
                    gap: gap,
                  ),
                  GButton(
                    icon: CupertinoIcons.bell,
                    text: 'Notifications',
                    iconColor: Theme.of(context).accentColor,
                    iconActiveColor: PrimaryYellow,
                    iconSize: 24,
                    textColor: Theme.of(context).accentColor,
                    padding: padding,
                    gap: gap,
                  ),
                  GButton(
                    icon: CupertinoIcons.person,
                    text: 'Profile',
                    iconColor: Theme.of(context).accentColor,
                    iconActiveColor: PrimaryYellow,
                    iconSize: 24,
                    textColor: Theme.of(context).accentColor,
                    padding: padding,
                    gap: gap,
                  ),
                ],
              selectedIndex: currentIndex,
              onTabChange: (index){
                  setState(() {
                    currentIndex = index;
                  });
                  _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: <Widget>[
            HomePage(),
            Bookings(),
            NotificationScreen(),
            ProfileScreen()
          ],
        ),
      ),
    );
  }
}
