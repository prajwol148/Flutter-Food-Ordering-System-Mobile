import 'package:flutter/material.dart';
import 'package:trial1/helpers/common.dart';
import 'package:trial1/screens/product_details.dart';
import '../widgets/bottom_navigation_icons.dart';
import '../helpers/style.dart';
import '../models/category.dart';
import '../provider/product.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading.dart';
import '../widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryScreen({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: widget.categoryModel.image,
          height: 40,
          width: double.infinity,
        ),
        // Text(
        //   "What would you like to eat?",
        //   style: TextStyle(
        //       color: Color(0xFF3a3737),
        //       fontSize: 16,
        //       fontWeight: FontWeight.w500),
        // ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 280.0, top: 18),
            child: CustomText(
              text: widget.categoryModel.name.toString(),
              color: black,
              size: 18,
              weight: FontWeight.w400,
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Column(
            children: productProvider.productsByCategory
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(
                            context,
                            ProductDetails(
                              product: item,
                            ));
                      },
                      child: ProductCard(
                        product: item,
                      ),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
