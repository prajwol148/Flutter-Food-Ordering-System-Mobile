import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';

import '../helpers/style.dart';
import 'custom_text.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryModel category;

  const CategoryWidget({Key key, this.category}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
            width: 100,
            height: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    )),
                    Center(
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: widget.category.image),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
