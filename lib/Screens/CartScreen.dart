import 'dart:convert';
import 'dart:ui';

import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/FoodScreen.dart';
import 'package:eatplek/Screens/OrderHistoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';
import 'DashBoardScreen.dart';

class CartScreen extends StatefulWidget {
  static const String id = '/order';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int n = 3, totalAmount = 0, status = -1;
  var cart;
  bool showSpinner = true;
  String resname = "", resId = "";
  List items = [];
  String comments = "", option = "";

  //todo:update n as no:of orders
  final _razorpay = Razorpay();
  var dt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getCart();
  }

  static const except = {'exc': 'An error occured'};

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Done");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/order');

    Map body1 = {
      "user_id": sharedPreferences.getString("id"),
      "comments": comments,
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.post(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "Order created successfully") {
        Navigator.pushReplacementNamed(context, OrderHistoryScreen.id);
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);

    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  getCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString("id");
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/cart/$userid');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      print(response.body);
      cart = await jsonData['cart'];

      resname = cart['restaurant_name'];
      resId = cart['restaurant_id'];
      items = cart['items'];
      totalAmount = cart['total_amount'];
      status = cart['status'];
      option = cart['type'];

      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        196;
    double h1 = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).viewInsets.bottom -
        100;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: const BottomBar(
          index: 1,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, DashBoardScreen.id);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff000000),
            ),
          ),
          title: const Text("Order Confirmation",
              style: TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontFamily: "SFUIText",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
              textAlign: TextAlign.left),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: CircularProgressIndicator(
              color: primaryclr,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18, top: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .042,
                                width: MediaQuery.of(context).size.width * .91,
                                decoration: BoxDecoration(
                                  color: Color(0xd1e1e1e1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 9),
                                      child: Image.asset(
                                        "images/loc.png",
                                        height: 16,
                                      ),
                                    ),
                                    Text(
                                      resname,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              children: [
                                const Text(
                                  'Choosen Option',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .042,
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    decoration: BoxDecoration(
                                      color: Color(0xd1e1e1e1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "images/cutlery.png",
                                            color: Color(0xff768BA3),
                                            height: 12,
                                            width: 15,
                                          ),
                                          Text(
                                            option,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                              fontFamily: 'SFUIText',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Items',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontFamily: 'SFUIText',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .05 *
                                              n,
                                      width: MediaQuery.of(context).size.width *
                                          .91,
                                      decoration: BoxDecoration(
                                        color: Color(0xd1e1e1e1),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 8),
                                        child: ListView.builder(
                                            itemCount: items.length,
                                            itemBuilder: (context, index) {
                                              return OrderSummary(
                                                  name: items[index]['name'],
                                                  count: items[index]
                                                      ['quantity'],
                                                  price: items[index]['total']
                                                      .toString(),
                                                  img:
                                                      "images/order_index.png");
                                            }),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .043,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .91,
                                          decoration: BoxDecoration(
                                            color: Color(0xd1e1e1e1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 3),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                ),
                                                Text(
                                                  'Add More',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11,
                                                    fontFamily: 'SFUIText',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FoodScreen(
                                                resId: resId,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Bill Details',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .134,
                                width: MediaQuery.of(context).size.width * .91,
                                decoration: BoxDecoration(
                                  color: Color(0xd1e1e1e1),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 12),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Item Total',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              totalAmount.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'Extra Charges',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              '₹ 0.0',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 9, top: 1),
                                        child: MySeparator(color: Colors.grey),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'To Pay',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              totalAmount.toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'SFUIText',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Comments (optional)',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 9, right: 18),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Color(0xd1e1e1e1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                onSubmitted: (val) {
                                  comments = val;
                                },
                                cursorColor: Colors.black,
                                cursorWidth: 1,
                                keyboardType: TextInputType.multiline,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5),
                                  hintText: 'Add your comment',
                                  hintStyle: TextStyle(
                                    color: Color(0x59000000),
                                    fontSize: 10,
                                    fontFamily: 'SFUIText',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? Container(
                        height: 78,
                        margin: const EdgeInsets.only(
                          left: 1,
                          right: 1,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(0, 4),
                              blurRadius: 17,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 11.40495777130127,
                                      fontFamily: 'SFUIText',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      totalAmount.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.107439041137695,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .38,
                                child: ProfileButton(
                                    text: "Proceed",
                                    onTap: () async {
                                      getCart();
                                      if (status == 0) {
                                        var options = {
                                          'key': 'rzp_live_Q5QUWIWRPFicsg',
                                          'amount': totalAmount *
                                              100, //in the smallest currency sub-unit.
                                          'name': 'Eatplek',
                                          // Generate order_id using Orders API
                                          'description': 'Pay',
                                          'timeout': 300, // in seconds
                                          'prefill': {
                                            'contact': '',
                                            'email': ''
                                          }
                                        };
                                        _razorpay.open(options);
                                      } else if (status == -1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 3),
                                            content: Text(
                                                "Sorry, Your order has not yet been approved by the restaurant!\nPlease wait a little bit"),
                                          ),
                                        );
                                      } else if (status == 1) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 2),
                                            content: Text(
                                                "Sorry, Your order has been rejected by the restaurant!"),
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrderSummary extends StatefulWidget {
  int count;
  String name;
  String price;
  String img;

  OrderSummary(
      {Key? key,
      required this.name,
      required this.count,
      required this.price,
      required this.img})
      : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(widget.img),
              ),
              Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 21),
                child: Row(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       if (widget.count > 0) {
                    //         widget.count--;
                    //       }
                    //     });
                    //   },
                    //   child: const Icon(
                    //     Icons.remove_circle,
                    //     color: Color(0xffc7c7c7),
                    //     size: 17,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        " ${widget.count} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.076922416687012,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     setState(() {
                    //       widget.count++;
                    //     });
                    //   },
                    //   child: const Icon(
                    //     Icons.add_circle,
                    //     color: Color(0xffffb800),
                    //     size: 17,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Text(
                '₹ ${widget.price}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
