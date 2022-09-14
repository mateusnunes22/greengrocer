import 'dart:convert';

import 'package:greengrocer/src/models/item_model.dart';

class CartItemModel {
  ItemModel item;
  int quantity;
  CartItemModel({
    required this.item,
    required this.quantity,
  });

  double totalPrice() => item.price * quantity;

  CartItemModel copyWith({
    ItemModel? item,
    int? quantity,
  }) {
    return CartItemModel(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item.toMap(),
      'quantity': quantity,
    };
  }

  static CartItemModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return CartItemModel(
        item: map['item'],
        quantity: map['quantity'],
      );
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static CartItemModel? fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  String toString() => 'CartItemModel(item: $item, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel &&
        other.item == item &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => item.hashCode ^ quantity.hashCode;
}
