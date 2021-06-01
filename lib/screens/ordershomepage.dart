import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'orders.dart';

class OrdersHomePage extends StatefulWidget {
  @override
  _OrdersHomePageState createState() {
    return _OrdersHomePageState();
  }
}

class _OrdersHomePageState extends State<OrdersHomePage> {
  List<charts.Series<Orders, String>> _seriesBarData;
  List<Orders> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Orders, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Orders orders, _) =>
            DateTime.fromMillisecondsSinceEpoch(orders.createdAt).toString(),
        measureFn: (Orders orders, _) => orders.total,
        id: 'Orders',
        data: mydata,
        labelAccessorFn: (Orders row, _) => "${row.createdAt}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('orders').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Orders> orders = snapshot.data.documents
              .map((documentSnapshot) => Orders.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, orders);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Orders> orderdata) {
    mydata = orderdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Orders by Year',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(
                  _seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds: 5),
                  behaviors: [
                    new charts.DatumLegend(
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.purple.shadeDefault,
                          fontFamily: 'Georgia',
                          fontSize: 10),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
