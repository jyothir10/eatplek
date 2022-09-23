import 'dart:convert';
import 'dart:ui';

import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/OrderHistoryCard.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/InvoiceScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashBoardScreen.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const String id = '/history';
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool showSpinner = true, fetched = false;
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

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      orders = await jsonData['result'];

      setState(() {
        showSpinner = false;
        fetched = true;
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
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          15 -
                          AppBar().preferredSize.height,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: orders.isEmpty && fetched == true
                            ? const Center(
                                child: Text(
                                  "No previous orders",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, index) {
                                  String status = "Preparing";
                                  if (orders[index]['status'] == 0) {
                                    status = "Delivered";
                                  } else if (orders[index]['status'] == 1) {
                                    status = "Delayed";
                                  }

                                  DateTime d = DateTime.parse(
                                      orders[index]["created_at"]);

                                  var formatter = new DateFormat('dd-MM-yyyy');
                                  String formattedDate = formatter.format(d);

                                  return OrderHistoryCard(
                                    resname: orders[index]['cart']
                                        ['restaurant_name'],
                                    date: formattedDate.toString(),
                                    totalAmount: orders[index]['cart']
                                            ['total_amount']
                                        .toString(),
                                    time: orders[index]['cart']['time']
                                        .toString(),
                                    status: status,
                                    n: orders[index]['cart']['items'].length -
                                        1,
                                    item1: orders[index]['cart']['items'][0]
                                        ['name'],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InvoiceScreen(
                                            orderId: orders[index]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
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
