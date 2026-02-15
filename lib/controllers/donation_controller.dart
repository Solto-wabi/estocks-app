import 'package:flutter/material.dart';
import '../models/donation_model.dart';
import '../main.dart';

class DonationController extends ChangeNotifier {
  final List<DonationModel> _history = [];

  List<DonationModel> get history => List.unmodifiable(_history);

  void registerReceived({
    required String itemName,
    required int quantity,
    String? from,
  }) {
    _history.add(
      DonationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        itemName: itemName,
        quantity: quantity,
        type: DonationType.received,
        partner: from,
        date: DateTime.now(),
      ),
    );

    final index =
        itemController.items.indexWhere((i) => i.name == itemName);

    if (index != -1) {
      final item = itemController.items[index];
      itemController.updateQuantity(
        item.id,
        item.quantity + quantity,
      );
    }

    notifyListeners(); // 🔥 ESSENCIAL
  }

  void registerGiven({
    required String itemName,
    required int quantity,
    String? to,
  }) {
    _history.add(
      DonationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        itemName: itemName,
        quantity: quantity,
        type: DonationType.given,
        partner: to,
        date: DateTime.now(),
      ),
    );

    final index =
        itemController.items.indexWhere((i) => i.name == itemName);

    if (index != -1) {
      final item = itemController.items[index];
      final newQuantity = item.quantity - quantity;

      itemController.updateQuantity(
        item.id,
        newQuantity < 0 ? 0 : newQuantity,
      );
    }

    notifyListeners(); // 🔥 ESSENCIAL
  }
}
