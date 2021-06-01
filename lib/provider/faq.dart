import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:trial1/models/faq.dart';


class FaqProvider with ChangeNotifier {
  FaqProvider.initialize() {
    loadFaqFromMongo();
  }

  List _mongoFaQs = [];
  List<FaqModel> _faqs = [];

  List<FaqModel> get faqs => _faqs;



  loadFaqFromMongo() async{
    final db = await Db.create("mongodb+srv://mahbubmunna:mahbub123456@cluster0.xvong.mongodb.net/testdatabase?retryWrites=true&w=majority");
    await db.open();
    var coll = db.collection('faqs');
    // Fluent way
    _mongoFaQs = await coll.find().toList();
    db.close();

    for(Map<String, dynamic> faq in _mongoFaQs) {
      _faqs.add(FaqModel.fromJson(faq));
    }

  }
}