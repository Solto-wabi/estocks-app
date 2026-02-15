import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../main.dart';
import '../services/notification_service.dart';

class ItemController extends ChangeNotifier {

  List<ItemModel> get items =>
      itemBox.values.cast<ItemModel>().toList();

  List<ItemModel> get lowStock =>
      items.where((item) => item.quantity <= 5).toList();

  List<ItemModel> get nearExpiry =>
      items.where((item) => item.isNearExpiry).toList();

  List<ItemModel> byCategory(String category) =>
      items.where((item) => item.category == category).toList();

  Future<void> add(ItemModel item) async {
    await itemBox.add(item);

    // 🔔 Notificação de vencimento (7 dias antes)
    if (item.expiresAt != null) {
      final scheduledDate =
          item.expiresAt!.subtract(const Duration(days: 7));

      if (scheduledDate.isAfter(DateTime.now())) {
        await NotificationService.scheduleNotification(
          id: item.hashCode,
          title: 'Item próximo do vencimento',
          body: '${item.name} vence em 7 dias',
          scheduledDate: scheduledDate,
        );
      }
    }

    // 🔔 Estoque baixo imediato
    if (item.quantity <= 5) {
      await NotificationService.instantNotification(
        id: item.hashCode + 1000,
        title: 'Estoque baixo',
        body: '${item.name} está com estoque baixo',
      );
    }

    notifyListeners();
  }

  Future<void> updateQuantity(String id, int newQuantity) async {
    final item =
        items.firstWhere((element) => element.id == id);

    item.quantity = newQuantity;
    await item.save();

    // 🔔 Se ficar baixo depois da edição
    if (newQuantity <= 5) {
      await NotificationService.instantNotification(
        id: item.hashCode + 2000,
        title: 'Estoque baixo',
        body: '${item.name} está com estoque baixo',
      );
    }

    notifyListeners();
  }

  Future<void> remove(String id) async {
    final item =
        items.firstWhere((element) => element.id == id);

    await item.delete();
    notifyListeners();
  }
}
