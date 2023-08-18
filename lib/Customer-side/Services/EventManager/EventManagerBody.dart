import 'package:flutter/material.dart';

import 'EventManagerComponents/Nearby_EventManager.dart';
import 'EventManagerComponents/TopPickedEventManager.dart';

class EventManagerBody extends StatelessWidget {

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
                    child: TopPickedEventManager(),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: NearByEventManager(),
                ),
              ],
            ),
          ),
        )
    );
  }
}
