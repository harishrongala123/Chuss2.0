import 'package:chuss/Customer-side/Services/Electrician/ElectricianComponents/Nearby_Electricians.dart';
import 'package:chuss/Customer-side/Services/Electrician/ElectricianComponents/TopPickedElectricians.dart';
import 'package:flutter/material.dart';

class ElectricianBody extends StatelessWidget {

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
                      child: TopPickedElectricians(),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearbyElectricians(),
                ),
              ],
            ),
          ),
        )
    );
  }
}

