import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentServices {
  String collection = "payment";
  Firestore _firestore = Firestore.instance;

  void createPayment({
    String userid,
    String name,
    dynamic amount,
    bool status,
  }) {
    _firestore.collection(collection).document(userid).setData({
      "userid": userid,
      "payname": name,
      "totalamount": amount * 100,
      "paymentstatus": status
    });
  }
}
