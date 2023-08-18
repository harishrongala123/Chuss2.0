import 'package:chuss/Customer-side/Services/BookingServices.dart';
import 'package:chuss/Technician_side/login/customlistanimation.dart';
import 'package:chuss/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class TechOrders extends StatefulWidget {
  @override
  _TechOrdersState createState() => _TechOrdersState();
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}


class _TechOrdersState extends State<TechOrders> {
  BookingServices _bookingServices = BookingServices();
  var currentUserPh = FirebaseAuth.instance.currentUser.phoneNumber;
  bool isStrechedDropDown = false;


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _bookingServices.orders
            .where('TechPhone', isEqualTo: currentUserPh)
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isStrechedDropDown = !isStrechedDropDown;
                        });
                      },
                      child: Column(
                        children: [
                          new Container(

                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  child: Icon( CupertinoIcons.square_list,)

                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Text(
                                    document['CustomerAddress'],
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
                                Expanded(
                                  child: Column(
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(isStrechedDropDown ? Icons.arrow_drop_up_sharp: Icons.arrow_drop_down_sharp,color: Theme.of(context).accentColor,),
                                ),

                              ],
                            ),
                          ),
                          ExpandedSection(
                            expand: isStrechedDropDown,height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10, top: 2),
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name : ${document['CustomerUsername']}',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        'PhoneNumber : ${document['CustomerPhone']}',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        'Address : ${document['CustomerAddress']}',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: ElevatedButton.icon(
                                                style:ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                                                  borderRadius: new BorderRadius.circular(25),
                                                ),
                                                  primary: Colors.black,
                                                ),
                                                onPressed: (){
                                                  customLaunch('tel:${document['CustomerPhone']}');
                                                },
                                                icon: Icon(Icons.phone,color: PrimaryYellow,),
                                                label: Text(''),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),

                            ),

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
    );
  }
}
