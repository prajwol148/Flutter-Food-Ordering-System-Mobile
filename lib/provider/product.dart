import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:trial1/models/product.dart';
import 'package:trial1/services/product.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsSearched = [];
  List<ProductModel> productsByCategory = [];

  ProductModel _productModel;

//  getter
  ProductModel get productModel => _productModel;

  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await _productServices.getProducts();
    notifyListeners();
  }

  Future loadProductsByCategory({String categoryName}) async {
    productsByCategory =
        await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future search({String productName}) async {
    productsSearched =
        await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }

  giveRatingToProduct(String userId, String productId, double productRating) async {
    Map<String, dynamic> data = {
      'user_id': userId,
      'product_id': productId,
      'product_rating': productRating,
    };
    bool isSuccess = await _productServices.giveRatingToProduct(data);
    if (isSuccess) {
      print('Successfully rated');
      toast('Successfully rated');
    }
    else print('Giving rating unsuccessful');
  }


}
