import 'package:flutter/material.dart';
import 'CateringServices.dart';
import 'SelectedCatering.dart';
import 'package:chuss/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class TopPickedCatering extends StatefulWidget {

  @override
  _TopPickedCateringState createState() => _TopPickedCateringState();
}

class _TopPickedCateringState extends State<TopPickedCatering> {

  CateringServices _CateringServices = CateringServices();
  User user = FirebaseAuth.instance.currentUser;
  var _userLatitude = 0.0;
  var _userLongitude = 0.0;

  void getData() async {
    DocumentSnapshot documentSnapshot;
    var currentUserPh = FirebaseAuth.instance.currentUser.phoneNumber;
    await FirebaseFirestore.instance
        .collection('UserData').doc(currentUserPh).get().then((result) {
      documentSnapshot = result;
    });
    _userLatitude = documentSnapshot['latitude'];
    _userLongitude = documentSnapshot['longitude'];

  }

  String getDistance(location){
    var distance = Geolocator.distanceBetween(_userLatitude, _userLongitude, location.latitude, location.longitude);
    var distanceInKm = distance/1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _CateringServices.getTopPickedTech(),
        builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapShot){
          if(!snapShot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  valueColor:AlwaysStoppedAnimation<Color>(PrimaryYellow),
            ));
          }
          List techDistance = [];
          for(int i = 0; i <= snapShot.data.docs.length-1; i++ ){
            var distance = Geolocator.distanceBetween(
                _userLatitude,
                _userLongitude,
                snapShot.data.docs[i]['location'].latitude,
                snapShot.data.docs[i]['location'].longitude);
            var distanceInKm = distance/1000;
            techDistance.add(distanceInKm);
          }
          techDistance.sort();
          if(techDistance[0] > 10){
            return Container(
              child: Center(
                child:
                Text(
                  'Service unavailable at this location',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 15),
                    child: Text('Most People Preferred',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapShot.data.docs.map((DocumentSnapshot document) {
                      if(double.parse(getDistance(document['location'])) <= 10) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 0.0,left: 0.0,right: 0.0,bottom: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              elevation: 0,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>SelectedCatering(document['phone'])
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Container(
                                width: 95,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      height: 95,
                                      child: Card(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(4),
                                            child: Image.network(
                                              document['imageUrl'],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                                      child: Container(
                                        height: 35,
                                        child: Text(
                                          document['username'], style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.bold,
                                          color: PrimaryYellow,
                                        ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '${getDistance(document['location'])}km',
                                        style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .accentColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      else{
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
