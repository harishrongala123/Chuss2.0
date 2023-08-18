import 'package:flutter/material.dart';
import 'TailorComponents/NearByTailors.dart';
import 'TailorComponents/TopPickedtailors.dart';

class TailorBody extends StatelessWidget {

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
                    child: TopPickedTailor(),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByTailor(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
