import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  static const ID = "id";
  static const IMAGE = "picture";
  static const NAME = "category";
  static const SIZES = "sizes";
  static const COLORS = "colors";

  String _id;
  String _image;
  String _name;
  List _sizes;
  List _colors;

  //  getters
  String get id => _id;

  String get image => _image;

  String get name => _name;

  List get sizes => _sizes;

  List get colors => _colors;

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _image = snapshot.data[IMAGE];
    _name = snapshot.data[NAME];
    _sizes = snapshot.data[SIZES];
    _colors = snapshot.data[COLORS];
  }
}
