import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const NAME = "name";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _name;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  dynamic _total;

//  getters
  String get id => _id;
  String get name => _name;

  String get description => _description;

  String get userId => _userId;

  String get status => _status;

  dynamic get total => _total;

  int get createdAt => _createdAt;

  // public variable
  List cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID]; //yesma
    _description = snapshot.data[DESCRIPTION];
    _total = snapshot.data[TOTAL];
    _name = snapshot.data[NAME];
    _status = snapshot.data[STATUS];
    _userId = snapshot.data[USER_ID];
    _createdAt = snapshot.data[CREATED_AT];
    cart = snapshot.data[CART];
  }
}
