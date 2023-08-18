import 'package:cloud_firestore/cloud_firestore.dart';

class MechanicServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Mechanic')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByMechanic(){
    return FirebaseFirestore.instance
        .collection('Mechanic')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByMechanicPagination(){
    return FirebaseFirestore.instance
        .collection('Mechanic')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}
