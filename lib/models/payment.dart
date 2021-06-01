import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  static const ID = "uid";
  static const PID = "id";
  static const NAME = "name";
  static const AMOUNT = "amount";
  static const STATUS = "status";

  String _uid;
  String _id;
  String _name;
  dynamic _amount;
  bool _status;

  //getter methods

  String get uid => _uid;

  String get id => _id;

  String get name => _name;

  dynamic get amount => _amount;

  bool get status => _status;

  PaymentModel.fromSnapshot(DocumentSnapshot snapshot) {
    _uid = snapshot.data[ID];
    _id = snapshot.data[PID];
    _name = snapshot.data[NAME];
    _amount = snapshot.data[AMOUNT];
    _status = snapshot.data[STATUS];
  }
}
