import 'package:flutter/material.dart';
import 'MechanicComponents/NearByMechanic.dart';
import 'MechanicComponents/TopPickedMechanic.dart';

class MechanicBody extends StatelessWidget {

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
                      child: TopPickedMechanic()
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByMechanic(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
