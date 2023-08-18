import 'package:cloud_firestore/cloud_firestore.dart';

class BuilderServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Builder')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByBuilders(){
    return FirebaseFirestore.instance
        .collection('Builder')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByBuildersPagination(){
    return FirebaseFirestore.instance
        .collection('Builder')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}
