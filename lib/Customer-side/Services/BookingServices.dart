import 'package:cloud_firestore/cloud_firestore.dart';

class BookingServices {
  CollectionReference orders = FirebaseFirestore.instance.collection('Bookings');

  Future<DocumentReference> saveOrder(Map<String,dynamic>data) async {
    var result = orders.add(
        data
    );
    return result;
  }
}