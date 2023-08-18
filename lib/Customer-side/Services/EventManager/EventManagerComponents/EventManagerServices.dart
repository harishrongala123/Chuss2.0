import 'package:cloud_firestore/cloud_firestore.dart';

class EventManagerServices{
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('EventManager')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByEventManager(){
    return FirebaseFirestore.instance
        .collection('EventManager')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByEventManagerPagination(){
    return FirebaseFirestore.instance
        .collection('EventManager')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}