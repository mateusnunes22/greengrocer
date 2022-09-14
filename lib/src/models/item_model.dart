import 'dart:convert';

class ItemModel {
  String itemName;
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  ItemModel copyWith({
    String? itemName,
    String? imgUrl,
    String? unit,
    double? price,
    String? description,
  }) {
    return ItemModel(
      itemName: itemName ?? this.itemName,
      imgUrl: imgUrl ?? this.imgUrl,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'imgUrl': imgUrl,
      'unit': unit,
      'price': price,
      'description': description,
    };
  }

  static ItemModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    try {
      return ItemModel(
        itemName: map['itemName'],
        imgUrl: map['imgUrl'],
        unit: map['unit'],
        price: map['price'],
        description: map['description'],
      );
    } catch (e) {
      return null;
    }
  }

  String toJson() => json.encode(toMap());

  static ItemModel? fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemModel &&
        other.itemName == itemName &&
        other.imgUrl == imgUrl &&
        other.unit == unit &&
        other.price == price &&
        other.description == description;
  }

  @override
  int get hashCode {
    return itemName.hashCode ^
        imgUrl.hashCode ^
        unit.hashCode ^
        price.hashCode ^
        description.hashCode;
  }
}
