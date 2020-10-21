class TicketModel {
  final String id, code;
  final bool etat;
  // ignore: non_constant_identifier_names
  final DateTime generate_at;

  // ignore: non_constant_identifier_names
  TicketModel({this.id, this.generate_at, this.code, this.etat});

  /*
   * Return List of Ticket  from Json
   */
  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: json['id'],
        code: json['code'],
        etat: json['etat'],
        generate_at: json['generate_at']);
  }

  /*
   * Return a Generated Ticket from Json
   */
  factory TicketModel.fromFetch(json) {
    return TicketModel(
        id: json['id'],
        code: json['code'],
        etat: json['etat'],
        generate_at: json['generate_at']);
  }
}
