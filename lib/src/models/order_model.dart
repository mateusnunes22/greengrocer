import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:greengrocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  List<CartItemModel> items;
  String status;
  String copyAndPaste;
  double total;
  OrderModel({
    required this.id,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
  });

  OrderModel copyWith({
    String? id,
    DateTime? createdDateTime,
    DateTime? overdueDateTime,
    List<CartItemModel>? items,
    String? status,
    String? copyAndPaste,
    double? total,
  }) {
    return OrderModel(
      id: id ?? this.id,
      createdDateTime: createdDateTime ?? this.createdDateTime,
      overdueDateTime: overdueDateTime ?? this.overdueDateTime,
      items: items ?? this.items,
      status: status ?? this.status,
      copyAndPaste: copyAndPaste ?? this.copyAndPaste,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdDateTime': createdDateTime.millisecondsSinceEpoch,
      'overdueDateTime': overdueDateTime.millisecondsSinceEpoch,
      'items': items.map((x) => x.toMap()).toList(),
      'status': status,
      'copyAndPaste': copyAndPaste,
      'total': total,
    };
  }

  static OrderModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return OrderModel(
        id: map['id'],
        createdDateTime:
            DateTime.fromMillisecondsSinceEpoch(map['createdDateTime']),
        overdueDateTime:
            DateTime.fromMillisecondsSinceEpoch(map['overdueDateTime']),
        items: List<CartItemModel>.from(
            map['items']?.map((x) => CartItemModel.fromMap(x))),
        status: map['status'],
        copyAndPaste: map['copyAndPaste'],
        total: map['total'],
      );
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static OrderModel? fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, createdDateTime: $createdDateTime, overdueDateTime: $overdueDateTime, items: $items, status: $status, copyAndPaste: $copyAndPaste, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.createdDateTime == createdDateTime &&
        other.overdueDateTime == overdueDateTime &&
        listEquals(other.items, items) &&
        other.status == status &&
        other.copyAndPaste == copyAndPaste &&
        other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdDateTime.hashCode ^
        overdueDateTime.hashCode ^
        items.hashCode ^
        status.hashCode ^
        copyAndPaste.hashCode ^
        total.hashCode;
  }
}
