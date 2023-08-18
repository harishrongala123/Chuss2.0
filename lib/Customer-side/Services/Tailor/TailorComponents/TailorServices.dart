import 'package:cloud_firestore/cloud_firestore.dart';

class TailorServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Tailor')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByTailor(){
    return FirebaseFirestore.instance
        .collection('Tailor')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByTailorPagination(){
    return FirebaseFirestore.instance
        .collection('Tailor')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}