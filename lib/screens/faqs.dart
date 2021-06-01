import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial1/helpers/style.dart';
import 'package:trial1/provider/faq.dart';
import 'package:trial1/widgets/expandable_item.dart';

class Faqs extends StatefulWidget {
  @override
  _FaqsState createState() => _FaqsState();
}

class _FaqsState extends State<Faqs> {

  @override
  Widget build(BuildContext context) {
    final faqProvider = Provider.of<FaqProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: Center(
          child: Text(
            "FAQs",
            style: TextStyle(
                color: Color(0xFF3a3737),
                fontWeight: FontWeight.w600,
                fontSize: 18),
            textAlign: TextAlign.left,
          ),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: faqProvider.faqs.length,
                  itemBuilder: (context, index) {
                return FaqExpandableItem(faq: faqProvider.faqs[index],);
              })
            ),
          ],
        ),
      ),
    );
  }
}
