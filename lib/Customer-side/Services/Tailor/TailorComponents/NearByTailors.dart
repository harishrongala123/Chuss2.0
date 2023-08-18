import 'package:chuss/components/constants.dart';
import 'package:flutter/material.dart';
import 'TailorServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'SelectedTailor.dart';

class NearByTailor extends StatefulWidget {

  @override
  _NearByTailorState createState() => _NearByTailorState();
}

class _NearByTailorState extends State<NearByTailor> {

  TailorServices _tailorServices = TailorServices();
  User user = FirebaseAuth.instance.currentUser;
  var _userLatitude = 0.0;
  var _userLongitude = 0.0;

  PaginateRefreshedChangeListener refreshedChangeListener = PaginateRefreshedChangeListener();

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
        stream: _tailorServices.getNearByTailor(),
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
              child: Center(child: Text(
                'No Tailor Near You',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),)),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RefreshIndicator(
                  child: PaginateFirestore(
                    header: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 10),
                            child: Text(
                              'All Nearby Tailors',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 10),
                            child: Text(
                              'Find Out Experienced Tailor Near You',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    isLive: true,
                    itemBuilderType: PaginateBuilderType.listView,
                    itemBuilder: (index, context, document) {
                      if(double.parse(getDistance(document['location'])) <= 10) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child:
                          Container(
                            color: Theme.of(context).primaryColor,
                            width: MediaQuery.of(context).size.width,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>SelectedTailor(document['phone'])
                                ));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 130,
                                    child: Card(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image.network(
                                          document['imageUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(document['username'],
                                          style: TextStyle(
                                            color: PrimaryYellow,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width-200,
                                        child: Text(
                                          document['description'],overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context).accentColor
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width-250,
                                        child: Text(
                                          document['address'],overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Theme.of(context).accentColor
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${getDistance(document['location'])}km',
                                        style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .accentColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 12,
                                            color: Theme.of(context).accentColor,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '3.9',
                                            style: TextStyle(
                                                color: Theme.of(context).accentColor,
                                                fontSize: 12
                                            ),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      }
                      return Container();
                    },
                    query: FirebaseFirestore.instance
                        .collection('Tailor')
                        .where('accVerified', isEqualTo: true)
                        .orderBy('username'),
                    listeners: [
                      refreshedChangeListener,
                    ],
                  ),
                  onRefresh: () async {
                    refreshedChangeListener.refreshed = true;
                  },
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}
