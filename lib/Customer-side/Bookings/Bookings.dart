import 'package:chuss/Customer-side/Services/BookingServices.dart';
import 'package:chuss/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/constants.dart';

class Bookings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookingServices _bookingServices = BookingServices();
    var currentUserPh = FirebaseAuth.instance.currentUser.phoneNumber;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Bookings',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _bookingServices.orders
              .where('CustomerPhone', isEqualTo: currentUserPh)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(PrimaryYellow),
              ));
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  'No Bookings Yet',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              );
            }
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                document['TechDp'],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                document['TechUsername'],
                                overflow: TextOverflow.ellipsis,
                                style:
                                TextStyle(
                                    color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Text(
                                  'On ${DateFormat.yMMMMEEEEd().add_jm().format(
                                    DateTime.parse(document['TimeStamp'].toDate().toString()))
                                  }',
                                  style:
                                  TextStyle(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
