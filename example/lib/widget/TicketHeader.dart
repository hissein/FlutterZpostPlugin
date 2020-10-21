import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  String image, title, subtitle, email, contact;
  Header(
      {Key key,
      @required this.size,
      @required this.image,
      @required this.title,
      @required this.contact,
      @required this.email})
      : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          image,
          color: Colors.black,
          width: size * 20,
        ),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size * 3,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size,
            ),
            Text(
              email,
              style: TextStyle(color: Colors.black, fontSize: size * 2),
            ),
            SizedBox(
              height: size,
            ),
            Text(
              contact,
              style: TextStyle(color: Colors.black, fontSize: size * 2),
            )
          ],
        ),
      ],
    );
  }
}
