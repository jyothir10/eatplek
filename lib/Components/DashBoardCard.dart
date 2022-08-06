import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class DashBoardCard extends StatelessWidget {
  final String text, rating, feeds, location, types;
  String img;
  final void Function() ontap;
  DashBoardCard(
      {Key? key,
      required this.text,
      required this.rating,
      required this.feeds,
      required this.location,
      required this.types,
      required this.img,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: ontap,
        child: Card(
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * .36,
                      height: MediaQuery.of(context).size.height * .12,
                      fit: BoxFit.cover,
                      imageUrl: img,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        color: primaryclr,
                      )),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Zinger Burger
                          Text(text,
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 17.5),
                              textAlign: TextAlign.left),
                          // ₹ 179
                          // Padding(
                          //     padding: EdgeInsets.symmetric(vertical: 6.2),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           Icons.star,
                          //           color: Color(0xffffb800),
                          //           size: 13.5,
                          //         ),
                          //         Text(
                          //           '$rating($feeds Feeds)',
                          //           style: TextStyle(
                          //             color: Color(0xff1d1d1d),
                          //             fontSize: 11.266666412353516,
                          //             fontFamily: 'SFUIText',
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          // French Fires
                          Text(
                            types,
                            style: const TextStyle(
                              color: Color(0xff1d1d1d),
                              fontSize: 10.140000343322754,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                          Text(
                            location,
                            style: TextStyle(
                              color: Color(0xff1d1d1d),
                              fontSize: 10.140000343322754,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
