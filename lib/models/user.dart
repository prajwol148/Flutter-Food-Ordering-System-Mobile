import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';
import 'favorite_item.dart';

class UserModel {
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PHONENUMBER = "phoneNumber";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const AVATARURL = "avatarUrl";
  static const FAVORITE = "favorite";
  static const DOB = "dob";

  String _email;
  String uid;
  String _phoneNumber;
  String _dob;
  String _stripeId;
  dynamic _priceSum = 0.0;

  String avatarUrl;
  String displayName;

//  getters
  String get name => displayName;

  String get email => _email;

  String get id => uid;

  String get displayUrl => avatarUrl;

  String get phoneNumber => _phoneNumber;

  String get stripeId => _stripeId;

  String get dob => _dob;

  UserModel(this.uid, {this.displayName, this.avatarUrl});

  // public variables
  List<CartItemModel> cart = [];
  List<FavoriteItemModel> favorite;
  dynamic totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    displayName = snapshot.data[NAME];
    _email = snapshot.data[EMAIL];
    uid = snapshot.data[ID];
    avatarUrl = snapshot.data[AVATARURL];
    _phoneNumber = snapshot.data[PHONENUMBER];
    _stripeId = snapshot.data[STRIPE_ID] ?? "";
    _dob = snapshot.data[DOB] ?? "";
    cart = _convertCartItems(snapshot.data[CART] ?? []);
    favorite = _convertFavoriteItems(snapshot.data[FAVORITE] ?? []);
    totalCartPrice = snapshot.data[CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data[CART]);
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  List<FavoriteItemModel> _convertFavoriteItems(List favorite) {
    List<FavoriteItemModel> convertedFavorite = [];
    for (Map favoriteItem in favorite) {
      convertedFavorite.add(FavoriteItemModel.fromMap(favoriteItem));
    }
    return convertedFavorite;
  }

  dynamic getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"];
    }

    dynamic total = _priceSum;
    return total;
  }
}
