import 'package:chuss/Customer-side/Home/MapScreen/Map_Screen.dart';
import 'package:chuss/Customer-side/Home/components/Location_provider.dart';
import 'package:flutter/material.dart';
import 'package:chuss/Customer-side/Home/components/homebody.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _location;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }
  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String location = prefs.getString('location');
    setState(() {
      _location = location;
    });
  }

  @override
  Widget build(BuildContext context) {

    final locationData = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            elevation: 0,
          ),
          onPressed: () async {
            await locationData.getCurrentPosition();
            if(locationData.permissionAllowed == true){
              Navigator.pushNamed(context, MapScreen.routeName);
            }else{
              print('Permission not allowed');
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  _location == null ? 'Select Address' : _location,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.edit,color: Theme.of(context).accentColor,)
            ],
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Body(),

    );
  }
}
