import 'package:eatplek/Screens/InvoiceScreen.dart';
import 'package:flutter/material.dart';
import 'package:eatplek/Components/OrderHistoryListCard.dart';
import 'package:eatplek/Components/BottomBar.dart';

class OrderHistoryScreen extends StatefulWidget {
  static const String id = '/history';
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        body: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height * .27,
                  width: MediaQuery.of(context).size.width * .9,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0xfff5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  // The Smocky Shack
                                  Text("The Smocky Shack",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.left),
                                  // 21-10-2022
                                  Text("21-10-2022",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 9.0),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  // Chengannur
                                  Text("Chengannur",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.0),
                                      textAlign: TextAlign.left),
                                  // 21-10-2022
                                  // 10:00 AM
                                  Text("10:00 AM",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 9.0),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                          Card(
                            color: const Color(0xffeeeeee),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: const [
                                  OrderHistoryListCard(
                                    name: "Zinger Burger",
                                    rate: "₹ 250",
                                  ),
                                  OrderHistoryListCard(
                                    name: "Zinger Burger",
                                    rate: "₹ 250",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.check_circle_sharp,
                                    color: Color(0xffbfbebf),
                                  ),
                                  Text(" Delivered",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.7),
                                      textAlign: TextAlign.left),
                                ],
                              ), // Delivered
                              InkWell(
                                radius: 5,
                                onTap: (){
                                  setState((){
                                    Navigator.pushNamed(
                                        context, InvoiceScreen.id);
                                  });
                                },
                                child: const Text("View Bill",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff284aff),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 10),
                                    textAlign: TextAlign.left),
                              ), // View Bill
                              Card(
                                color: Color(0xff042e60),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: // Repeat Order
                                    const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Repeat Order",
                                      style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 10.8),
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(index: 2,),
      ),
    );
  }
}


