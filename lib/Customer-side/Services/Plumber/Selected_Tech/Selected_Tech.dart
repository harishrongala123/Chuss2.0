import 'package:chuss/Customer-side/Services/BookingServices.dart';
import 'package:chuss/Customer-side/Services/HeaderCurvedContainer.dart';
import 'package:chuss/components/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';


class SelectedTechnician extends StatefulWidget {
  final String uID;

  SelectedTechnician(this.uID);

  @override
  _SelectedTechnicianState createState() => _SelectedTechnicianState();
}

class GetID {
  String getDocID;

  GetID({this.getDocID});
}

BookingServices _orderServices = BookingServices();

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

var cID = FirebaseAuth.instance.currentUser.phoneNumber;

class _SelectedTechnicianState extends State<SelectedTechnician> {
  String id = GetID().getDocID;

  @override
  void initState() {
    super.initState();
    id = widget.uID;
  }

  @override
  Widget build(BuildContext context) {
    Stream document =
        FirebaseFirestore.instance.collection('UserData').doc(cID).snapshots();
    Stream documentStream =
        FirebaseFirestore.instance.collection('Plumber').doc(id).snapshots();
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
          stream: documentStream,
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapShotTech) {
            if (!snapShotTech.hasData) return CircularProgressIndicator();
            return StreamBuilder<DocumentSnapshot>(
              stream: document,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapShotCustomer) {
                return Scaffold(
                  bottomNavigationBar: ClayContainer(
                    color: Theme.of(context).primaryColor,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(0),
                                ),
                                primary: Theme.of(context).primaryColor),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Call',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: PrimaryYellow),
                                ),
                              ],
                            ),
                            onPressed: () {
                              customLaunch('tel:${snapShotTech.data['phone']}');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(0),
                                ),
                                primary: Theme.of(context).primaryColor),
                            child: Text(
                              'Book',
                              style: TextStyle(
                                  color: PrimaryYellow,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        height: 200,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'Are you sure you want to book ${snapShotTech.data['username']} to this address ',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${snapShotCustomer.data['address']}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _orderServices.saveOrder({
                                                      'Service': 'Plumber',
                                                      'TechUsername': snapShotTech.data['username'],
                                                      'TechDp': snapShotTech.data['imageUrl'],
                                                      'BookingStatus': 'Booked',
                                                      'TechPhone': snapShotTech.data['phone'],
                                                      'CustomerPhone': snapShotCustomer.data['PhoneNumber'],
                                                      'CustomerUsername': snapShotCustomer.data['UserName'],
                                                      'TimeStamp': DateTime.now(),
                                                      'CustomerAddress': snapShotCustomer.data['address'],
                                                    });
                                                    EasyLoading.showSuccess(
                                                        'Your Booking is Done');
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary:
                                                              PrimaryYellow),
                                                  child: Text(
                                                    'Confirm',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              CustomPaint(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                                painter: HeaderCurvedContainer(),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'PLUMBER',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    width:
                                        MediaQuery.of(context).size.width / 2.8,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 3),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).primaryColor,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapShotTech.data['imageUrl']),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Text(
                                    snapShotTech.data['username'],
                                    style: TextStyle(
                                        color: PrimaryYellow,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'About ${snapShotTech.data['username']}',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20, right: 20),
                                      child: Text(
                                        snapShotTech.data['description'],
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 15,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20, right: 20),
                                      child: Text(
                                        'Email Address      : '+ snapShotTech.data['email']
                                            +'\nContact Number  : '+snapShotTech.data['phone'],

                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color:
                                            Theme.of(context).accentColor,
                                            fontSize: 15,
                                            letterSpacing: 1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

