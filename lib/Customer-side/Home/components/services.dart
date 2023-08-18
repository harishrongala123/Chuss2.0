import 'package:chuss/Customer-side/Services/Builder/Builder.dart';
import 'package:chuss/Customer-side/Services/Carpenter/Carpenter.dart';
import 'package:chuss/Customer-side/Services/Catering/Catering.dart';
import 'package:chuss/Customer-side/Services/Electrician/Electrician.dart';
import 'package:chuss/Customer-side/Services/EventManager/EventManager.dart';
import 'package:chuss/Customer-side/Services/Mechanic/Mechanic.dart';
import 'package:chuss/Customer-side/Services/Painter/Painter.dart';
import 'package:chuss/Customer-side/Services/Plumber/Plumber.dart';
import 'package:chuss/Customer-side/Services/Tailor/Tailor.dart';
import 'package:chuss/components/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,

          ),
          children: [
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/plumber.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Plumber',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Plumber())
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),

            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/carpenter.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Carpenter',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Carpenter())
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/electrician.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Electrician',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Electrician()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/builder.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Builder',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Builders()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/catering.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Catering',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Catering()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/mechanic.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Mechanic',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Mechanic()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/painter.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Painter',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Painter()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/tailor.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'Tailor',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Tailor()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            ClayContainer(
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        'assets/icons/plumber.svg',
                        height: 40,
                        width: 40,
                        color: PrimaryYellow,
                      ),
                    ),
                    Text(
                      'EventPlaner',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if(states.contains(MaterialState.pressed))
                    return Theme.of(context).primaryColor;
                  return Theme.of(context).primaryColor;
                })),

                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EventManager()),
                  );
                },),
              color: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),

          ],
        ),
      ),
    );
  }
}

