import 'package:cloud_firestore/cloud_firestore.dart';

class CateringServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Catering')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByCatering(){
    return FirebaseFirestore.instance
        .collection('Catering')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByCateringPagination(){
    return FirebaseFirestore.instance
        .collection('Catering')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}
