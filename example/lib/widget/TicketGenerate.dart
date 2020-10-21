import 'package:ZpostCliv2_example/ticket.dart';
import 'package:ZpostCliv2_example/widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketGenerate extends StatelessWidget {
  const TicketGenerate({
    Key key,
    @required this.ticket,
    @required this.f,
  }) : super(key: key);

  final TicketModel ticket;
  final DateFormat f;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "N°:",
          style: TextStyle(fontSize: defaultSize * 4),
        ),
        Text(
          ticket.code,
          style: TextStyle(fontSize: defaultSize * 7),
        ),
        Text(
          "Personne en attente(s): " + "110",
          style: TextStyle(fontSize: defaultSize * 3),
        ),
        SizedBox(
          height: defaultSize,
        ),
        Text(
          "Date & Heure :${f.format(ticket.generate_at)}",
          style: TextStyle(fontSize: defaultSize * 2.3),
        )
      ],
    );
  }
}
