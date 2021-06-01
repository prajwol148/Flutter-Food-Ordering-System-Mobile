import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:trial1/helpers/common.dart';
import 'package:trial1/helpers/style.dart';
import 'package:trial1/provider/category.dart';
import 'package:trial1/provider/product.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/screens/about_us.dart';
import 'package:trial1/screens/chatbot.dart';
import 'package:trial1/screens/faqs.dart';
import 'package:trial1/screens/favorite.dart';
import 'package:trial1/screens/ordershomepage.dart';
import 'package:trial1/screens/product_search.dart';
import 'package:trial1/screens/profile.dart';
import 'package:trial1/services/product.dart';
import 'package:trial1/widgets/avatar.dart';
import 'package:trial1/widgets/categories.dart';
import 'package:trial1/widgets/custom_text.dart';
import 'package:trial1/widgets/featured_products.dart';
import 'package:trial1/widgets/product_card.dart';

import 'cart.dart';
import 'category.dart';
import 'order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _key = GlobalKey<ScaffoldState>();
  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Image.asset(
          'assets/images/menus/logo.png',
          height: 80,
          width: 50,
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
            padding: EdgeInsets.only(right: 0.0, top: 25),
            child: Text(
              "What would you like to eat?",
              style: TextStyle(
                  color: Color(0xFF3a3737),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0, top: 15),
            child: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                changeScreen(context, FavoriteScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0, top: 15),
            child: IconButton(
              icon: Icon(
                Icons.menu_outlined,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                _key.currentState.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.red[700]),
              currentAccountPicture: Padding(
                padding: EdgeInsets.all(0),
                child: Avatar(
                  avatarUrl: userProvider.userModel?.avatarUrl,
                  onTap: () {},
                ),
              ),
              accountName: CustomText(
                text: userProvider.userModel?.name ?? "username lading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: userProvider.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: CustomText(text: "My Order History"),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_basket),
              title: CustomText(text: "My Cart"),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, Profile());
              },
              leading: Icon(Icons.person),
              title: CustomText(text: "My Profile"),
            ),
            ListTile(
              onTap: () async {
                changeScreen(context, MyApp());
              },
              leading: Icon(Icons.chat_rounded),
              title: CustomText(text: "Chatbot"),
            ),
            ListTile(
              onTap: () async {
                changeScreen(context, Faqs());
              },
              leading: Icon(Icons.question_answer),
              title: CustomText(text: "FAQ"),
            ),
            ListTile(
              onTap: () async {
                await userProvider.getOrders();
                changeScreen(context, AboutUs());
              },
              leading: Icon(Icons.info_rounded),
              title: CustomText(text: "About Us"),
            ),
            ListTile(
              onTap: () {
                userProvider.signOut();
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
//          Search Text field
//            Search(),

            Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.red[700],
                    ),
                    title: TextField(
                      textInputAction: TextInputAction.search,
                      onSubmitted: (pattern) async {
                        await productProvider.search(productName: pattern);
                        changeScreen(context, ProductSearchScreen());
                      },
                      decoration: InputDecoration(
                        hintText: "Chicken Burge...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Categories')),
                ),
              ],
            ),

            Container(
              height: 80,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
//                              app.changeLoading();
                        await productProvider.loadProductsByCategory(
                            categoryName:
                                categoryProvider.categories[index].name);

                        changeScreen(
                            context,
                            CategoryScreen(
                              categoryModel: categoryProvider.categories[index],
                            ));

//                              app.changeLoading();
                      },
                      child: CategoryWidget(
                        category: categoryProvider.categories[index],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 5,
            ),

//            featured products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Recommended For You')),
                ),
              ],
            ),
            FeaturedProducts(),
            SizedBox(
              height: 35,
            ),

//          recent products
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: new Text('Trending Foods')),
                ),
              ],
            ),

            Column(
              children: productProvider.products
                  .map((item) => GestureDetector(
                        child: ProductCard(
                          product: item,
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
//Row(
//mainAxisAlignment: MainAxisAlignment.end,
//children: <Widget>[
//GestureDetector(
//onTap: (){
//key.currentState.openDrawer();
//},
//child: Icon(Icons.menu))
//],
//),
