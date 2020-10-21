import 'package:ZpostCliv2_example/widget/CopyRight.dart';
import 'package:ZpostCliv2_example/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import '../ticket.dart';
import 'TicketGenerate.dart';
import 'TicketHeader.dart';
import 'TicketMessage.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;

  const CardWidget({
    @required this.title,
    @required this.description,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat(' dd/MM/yyyy à hh:mm');

    TicketModel ticket = new TicketModel(
        id: "5f7b2215f947dc3979b5de5d",
        code: "wa-3",
        etat: true,
        generate_at: new DateTime.fromMicrosecondsSinceEpoch(1601905173681));
    SizeConfig().init(context);
    final double radius = 16;
    PdfPageFormat format = PdfPageFormat.roll80;
    double size = MediaQuery.of(context).size.width;
    double defaultSize = SizeConfig.defaultSize;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: size * .01, bottom: size * 0.3),
      child: Column(
        children: [
          Header(
              size: defaultSize,
              image: "images/logo.png",
              title: "Mousaida",
              contact: "01 23 45 67 89 ",
              email: "contact@hiboutik.com"),
          Center(
            child: Column(
              children: [
                TicketGenerate(ticket: ticket, f: f),
                MessageTicket(message: "Merci de patienter !"),
                CopyRight()
              ],
            ),
          )
        ],
      ),
    );
  }
}
