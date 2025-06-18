import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:kiss_queue/kiss_queue.dart';

class Order {
  final String orderId;
  final String customerId;
  final double amount;
  final List<String> items;

  Order({
    required this.orderId,
    required this.customerId,
    required this.amount,
    required this.items,
  });

  @override
  String toString() =>
      'Order($orderId: \$${amount.toStringAsFixed(2)} for $customerId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          orderId == other.orderId &&
          customerId == other.customerId &&
          amount == other.amount &&
          const ListEquality<String>().equals(items, other.items);

  @override
  int get hashCode => Object.hash(orderId, customerId, amount, items);

  static Order orderFromJson(Map<String, dynamic> json) => Order(
    orderId: json['orderId'],
    customerId: json['customerId'],
    amount: json['amount'],
    items: (json['items'] as List<dynamic>).map((e) => e.toString()).toList(),
  );

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'customerId': customerId,
    'amount': amount,
    'items': items,
  };
}

class TestJsonStringSerializer implements MessageSerializer<Order, String> {
  @override
  String serialize(Order payload) {
    try {
      return jsonEncode(payload.toJson());
    } catch (e) {
      throw SerializationError(
        'Failed to serialize TestOrder to JSON string',
        e,
      );
    }
  }

  @override
  Order deserialize(String data) {
    try {
      final json = jsonDecode(data);
      return Order.orderFromJson(json);
    } catch (e) {
      throw DeserializationError(
        'Failed to deserialize JSON string to TestOrder',
        data,
        e,
      );
    }
  }
}
