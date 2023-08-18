import 'package:chuss/Technician_side/TechHome/Components/TechNavigationBar.dart';
import 'package:chuss/Technician_side/TechOrders/TechOrders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class TechHome extends StatefulWidget {
  const TechHome({Key key}) : super(key: key);



  @override
  _TechHomeState createState() => _TechHomeState();
}

class _TechHomeState extends State<TechHome> {

  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text( 'Bookings'),
        centerTitle: true,
      ),
      body: TechOrders(),
    );
  }
}
