import 'package:chuss/Customer-side/CustomerNav/CustomerNavigationbar.dart';
import 'package:chuss/Customer-side/Home/components/Location_provider.dart';
import 'package:chuss/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static String routeName = '/Map_Screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng currentLocation;
  GoogleMapController _mapController;
  bool _location = false;
  bool isMapCreated = false;
  final theme = WidgetsBinding.instance.window.platformBrightness;
  changeMapMode(){
    if(theme == Brightness.light){
      getJsonFile("assets/map_styles/Retro.json").then(setMapStyle);
    } else {
      getJsonFile("assets/map_styles/night.json").then(setMapStyle);
    }
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _mapController.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);

    if(isMapCreated = true) {
      changeMapMode();
    }

    setState(() {
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
    });

    void onCreated (GoogleMapController controller) {
      setState(() {
        _mapController = controller;
        isMapCreated = true;
        changeMapMode();
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: currentLocation,zoom: 14.4746,),
              zoomControlsEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference(1.5,20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition position){
                setState(() {
                  _location = true;
                });
                locationData.onCameraMove(position);
              },
              onMapCreated: onCreated,
              onCameraIdle: (){
                setState(() {
                  _location = false;
                });
                locationData.getMoveCamera();
              },

            ),

            Center(
              child: Container(
                height: 40,
                margin: EdgeInsets.only(bottom: 40),
                child: SvgPicture.asset('assets/icons/location_pin.svg',color: Theme.of(context).accentColor,),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _location ? LinearProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(PrimaryYellow),
                        backgroundColor: Colors.transparent,
                      ) : Container(),
                      TextButton.icon(
                        onPressed: (){}, icon: Icon(Icons.location_searching,color: PrimaryYellow,),
                        label:  Flexible(
                          child: Text( _location ? 'Locating...' : locationData.selectedAddress.featureName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).accentColor,
                      ),
                      ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(_location ? '' : locationData.selectedAddress.addressLine,
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: SizedBox(
                            child: AbsorbPointer(
                              absorbing: _location ? true : false,
                              child: ElevatedButton(
                                onPressed: () {
                                  locationData.savePrefs();
                                  var currentUserPhoneNumber = FirebaseAuth.instance.currentUser.phoneNumber;
                                  FirebaseFirestore.instance.collection('UserData')
                                  .doc(currentUserPhoneNumber)
                                  .update({
                                    'latitude' : locationData.latitude,
                                    'longitude' : locationData.longitude,
                                    'address' : locationData.selectedAddress.addressLine,
                                  }
                                  );
                                  Phoenix.rebirth(context);
                                  },
                                style: ElevatedButton.styleFrom(

                                  primary:_location ? Colors.blueGrey : PrimaryYellow,
                                ),
                                child: Text('CONFIRM LOCATION',style: TextStyle(
                                  color:  Theme.of(context).primaryColor,
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
