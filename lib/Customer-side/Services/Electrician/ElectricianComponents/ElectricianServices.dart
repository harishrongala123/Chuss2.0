import 'package:cloud_firestore/cloud_firestore.dart';

class ElectricianServices{
  getTopPickedTech() {
    return FirebaseFirestore.instance
        .collection('Electrician')
        .where('accVerified', isEqualTo: true)
        .where('isTopPicked', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }

  getNearByElectricians(){
    return FirebaseFirestore.instance
        .collection('Electrician')
        .where('accVerified', isEqualTo: true)
        .orderBy('username')
        .snapshots();
  }
  getNearByElectriciansPagination(){
    return FirebaseFirestore.instance
        .collection('Electrician')
        .where('accVerified', isEqualTo: true)
        .orderBy('username');
  }
}