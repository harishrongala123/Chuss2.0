import 'package:cloud_firestore/cloud_firestore.dart';

class CarpenterServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Carpenter')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByCarpenters(){
    return FirebaseFirestore.instance
        .collection('Carpenter')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByCarpentersPagination(){
    return FirebaseFirestore.instance
        .collection('Carpenter')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}
