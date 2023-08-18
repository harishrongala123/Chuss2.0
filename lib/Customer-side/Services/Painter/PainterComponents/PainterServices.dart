import 'package:cloud_firestore/cloud_firestore.dart';

class PainterServices {
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Painter')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByPainter(){
    return FirebaseFirestore.instance
        .collection('Painter')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByPainterPagination(){
    return FirebaseFirestore.instance
        .collection('Painter')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}