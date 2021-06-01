import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:trial1/models/faq.dart';

class FaqExpandableItem extends StatefulWidget {
  final FaqModel faq;
  FaqExpandableItem({this.faq});
  @override
  _FaqExpandableItemState createState() => _FaqExpandableItemState();
}

class _FaqExpandableItemState extends State<FaqExpandableItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 2,),
        ExpandablePanel(
          header: Text(widget.faq.question?? 'Loading ..', textScaleFactor: 1.5,),
          collapsed:Container(),
          expanded: Text(widget.faq.answer?? 'Loading ..', textScaleFactor: 1.3,),
        ),
        Divider(thickness: 1.5,)
      ],
    );
  }
}
