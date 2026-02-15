enum DonationType {
  received, // recebemos doação
  given,    // doamos para alguém
}

class DonationModel {
  final String id;
  final String itemName;
  final int quantity;
  final DonationType type;
  final String? partner; // quem doou OU quem recebeu
  final DateTime date;

  DonationModel({
    required this.id,
    required this.itemName,
    required this.quantity,
    required this.type,
    this.partner,
    required this.date,
  });
}
