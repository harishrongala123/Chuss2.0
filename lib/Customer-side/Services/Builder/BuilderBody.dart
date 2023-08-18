import 'package:chuss/Customer-side/Services/Builder/BuilderComponents/Nearby_Builders.dart';
import 'package:chuss/Customer-side/Services/Builder/BuilderComponents/TopPickedBuilder.dart';
import 'package:flutter/material.dart';


class BuilderBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child:Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Card(
                  elevation: 4.0,
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      height: 230,
                      child: TopPickedBuilder()
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByBuilders(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
