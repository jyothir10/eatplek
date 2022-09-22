import 'dart:convert';
import 'dart:ui';

import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/OrderHistoryCard.dart';
import 'DashBoardScreen.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const String id = '/history';
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool showSpinner = true;
  var orders = [];

  getOrders() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString("id");
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/order/filter/user/$userid');

    http.Response response = await http.get(urlfinal, headers: headers);
    print(response.statusCode);
    print(response.body);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      orders = await jsonData['result'];

      print(orders);

      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: // Your Order
              const Text("Your Order",
                  style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontFamily: "SFUIText",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0),
                  textAlign: TextAlign.left),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryclr,
          ),
          child: Container(
            color: Colors.white,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: OrderHistoryCard(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const BottomBar(
          index: 2,
        ),
      ),
    );
  }
}
