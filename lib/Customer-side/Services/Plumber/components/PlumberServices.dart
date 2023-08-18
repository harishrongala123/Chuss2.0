import 'package:cloud_firestore/cloud_firestore.dart';

class PlumberServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Plumber')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByPlumbers(){
    return FirebaseFirestore.instance
        .collection('Plumber')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByPlumbersPagination(){
    return FirebaseFirestore.instance
        .collection('Plumber')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}
