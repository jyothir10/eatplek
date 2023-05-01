import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ProfileOption2 extends StatelessWidget {
  final String name;
  final String url;
  final IconData icon;
  const ProfileOption2(
      {Key? key, required this.name, required this.url, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Link(
      target: LinkTarget.defaultTarget,
      uri: Uri.parse(url),
      builder: (context, followLink) => GestureDetector(
        onTap: followLink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 11.5),
                  child: Icon(
                    icon,
                    size: 17,
                    color: Colors.black,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'SFUIText',
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Color(0x89292d32),
            ),
          ],
        ),
      ),
    );
  }
}
