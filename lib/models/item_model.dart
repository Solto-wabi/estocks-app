import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  DateTime? expiresAt;

  @HiveField(4)
  String category;

  ItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    this.expiresAt,
    required this.category,
  });

  bool get isNearExpiry {
    if (expiresAt == null) return false;
    final difference = expiresAt!.difference(DateTime.now()).inDays;
    return difference <= 7 && difference >= 0;
  }
}
