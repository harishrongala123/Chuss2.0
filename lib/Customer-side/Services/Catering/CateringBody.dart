import 'package:chuss/Customer-side/Services/Catering/CateringComponents/NearbyCatering.dart';
import 'package:chuss/Customer-side/Services/Catering/CateringComponents/TopPickedCatering.dart';
import 'package:flutter/material.dart';
class CateringBody extends StatelessWidget {

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
                      child: TopPickedCatering()
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByCatering(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
