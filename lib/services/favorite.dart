import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trial1/models/favorite_item.dart';
import 'package:trial1/models/favorite.dart';

class FavoriteServices {
  String collection = "favorites";
  Firestore _firestore = Firestore.instance;

  void createFavorite(
      {String userId,
      String id,
      String description,
      String status,
      List<FavoriteItemModel> favorite,
      int totalPrice}) {
    List<Map> convertedFavorite = [];

    for (FavoriteItemModel item in favorite) {
      convertedFavorite.add(item.toMap());
    }

    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "favorite": convertedFavorite,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<FavoriteModel>> getUserFavorites({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<FavoriteModel> favorites = [];
        for (DocumentSnapshot favorite in result.documents) {
          favorites.add(FavoriteModel.fromSnapshot(favorite));
        }
        return favorites;
      });
}
