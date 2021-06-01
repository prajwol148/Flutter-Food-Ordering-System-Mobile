import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trial1/helpers/roundedborder.dart';
import 'package:trial1/models/order.dart';
import 'package:trial1/screens/home.dart';
import 'package:trial1/screens/order.dart';
import 'package:trial1/services/payment.dart';
import 'package:vector_math/vector_math_operations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../screens/cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

PaymentServices _paymentServices = PaymentServices();
OrderModel orderModel;

// ignore: must_be_immutable
class Pay extends StatefulWidget {
  //Pay({Key key}) : super(key: key);
  var id;
  var name;
  dynamic totalPrice;

  Pay({Key key, this.id, this.name, this.totalPrice}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  void initstate() {
    super.initState();
  }

  void verify(Map<dynamic, dynamic> z) async {
    //Map<String, dynamic> user = convert.jsonDecode(z);
    String tkn = z['token'];
    var amnt = z['amount'].toString();

    try {
      var last = Uri.parse('https://khalti.com/api/v2/payment/verify/');
      var ssv = await http.post(last, body: {
        'token': tkn,
        'amount': amnt
      }, headers: {
        'Authorization': 'test_secret_key_2339900d67b045a79bc622c70f5d925a'
      });

      print("Response status : ${ssv.statusCode}");
      print("Content : ${ssv.body}");
    } catch (e) {
      print("Something went wrong");
    }
  }

  _khaltipay() async {
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_a0a9cbe706124351bffa0000cfa54666",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
      paymentPreferences: [
        KhaltiPaymentPreference.KHALTI,
      ],
    );
    void showToast() {
      Fluttertoast.showToast(
          msg: 'Payment has been sucessfully made',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.yellow);
    }

    // double.parse(widget.total);
    KhaltiProduct product = KhaltiProduct(
        id: widget.id.toString(),
        name: widget.name.toString(),
        amount: double.parse(widget.totalPrice.toString()) * 100);

    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) {
        Map<dynamic, dynamic> s = data;
        //dynamic z = jsonEncode(data); //convert map to json value
        //dynamic a = JsonEncoder(z); //convert json to string

        verify(s);

        Timer(Duration(seconds: 3), () {
          showToast();
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      },
      onFaliure: (error) {
        print("Sorry");
      },
    );
  }

  Future _hello() async {
    _paymentServices.createPayment(
        userid: widget.id.toString(),
        name: "Your Total bill is",
        amount: double.parse(widget.totalPrice.toString()),
        status: true);

    widget.id = "";
    widget.name = "";
    widget.totalPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "Select a payment method",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    margin: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 15.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            width: 130,
                            height: 130,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/logo.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),
            RoundedContainer(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    SnackBar(content: Text("Successfull!"));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset('assets/money.png', width: 200.0),
                    ),
                  ),
                )
                // leading: Icon(
                //   Icons.money_rounded,
                //   color: Colors.indigo,
                // ),
                // title: Text("Cash on Delivery"),
                // trailing: Icon(Icons.arrow_forward_ios),
                // onTap: () {
                //   SnackBar(content: Text("Successfull!"));
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => HomePage()));
                // }
                //
                //
                ),
            RoundedContainer(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    _khaltipay();
                    //     _hello();
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset('assets/khalti.png', width: 250.0),
                    ),
                  ),
                )

                // child: ListTile(
                //   leading: Icon(
                //     Icons.credit_card_rounded,
                //     color: Colors.indigo,
                //   ),
                //   onTap: () {
                //     _khaltipay();
                //     _hello();
                //     // _key.currentState.showSnackBar(SnackBar(
                //     //     backgroundColor: Colors.blueAccent,
                //     //     behavior: SnackBarBehavior.floating,
                //     //     content: Text(
                //     //       "Your password resent link has been sent to your Gmail account.Please check",
                //     //       style: TextStyle(
                //     //         fontSize: 17,
                //     //       ),
                //     //     )));
                //   },
                //   title: Text("Khalti"),
                //   trailing: Icon(Icons.arrow_forward_ios),
                // ),
                ),
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}
