import 'package:ZpostCliv2_example/widget/utils.dart';
import 'package:flutter/material.dart';

class MessageTicket extends StatelessWidget {
  final String message;
  MessageTicket({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Column(
      children: [
        SizedBox(
          height: defaultSize * 4,
        ),
        Text(
          "***********************",
          style: TextStyle(fontSize: defaultSize * 3),
        ),
        SizedBox(
          height: defaultSize * .3,
        ),
        Text(
          message,
          style: TextStyle(fontSize: defaultSize * 3),
        ),
        SizedBox(
          height: defaultSize * .3,
        ),
        Text(
          "***********************",
          style: TextStyle(fontSize: defaultSize * 3),
        ),
      ],
    );
  }
}
