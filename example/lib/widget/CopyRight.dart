import 'package:ZpostCliv2_example/widget/utils.dart';
import 'package:flutter/material.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Column(
      children: [
        SizedBox(
          height: defaultSize,
        ),
        Text(
          "Mousaida",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: defaultSize * 4),
        ),
        SizedBox(
          height: defaultSize,
        ),
        Text(
          "Lomé - AGOE",
          style: TextStyle(color: Colors.black, fontSize: defaultSize * 3),
        ),
      ],
    );
  }
}
