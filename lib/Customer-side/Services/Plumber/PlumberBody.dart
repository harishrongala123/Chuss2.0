import 'package:chuss/Customer-side/Services/Plumber/components/Nearby_Technicians.dart';
import 'package:chuss/Customer-side/Services/Plumber/components/TopPicked.dart';
import 'package:flutter/material.dart';

class PlumberBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Card(
                  elevation: 4.0,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 230,
                      child: TopPicked()
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByTech(),
                ),
              ],
            ),
          ),
    )
    );
  }
}
