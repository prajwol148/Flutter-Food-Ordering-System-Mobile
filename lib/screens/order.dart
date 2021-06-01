import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial1/helpers/style.dart';
import 'package:trial1/models/order.dart';
import 'package:trial1/provider/user.dart';
import 'package:trial1/widgets/custom_text.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = userProvider.orders[index];
            return ListTile(
              leading: CustomText(
                text: " Npr. ${_order.total}",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description),
              subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(_order.createdAt)
                      .toString()),
              trailing: IconButton(
                  icon: Icon(
                    Icons.download_done_rounded,
                    color: green,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            );
          }),
    );
  }
}
