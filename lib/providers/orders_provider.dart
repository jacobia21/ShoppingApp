import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../providers/carts_provider.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> cartItems;
  final DateTime timeOrdered;

  Order(
      {@required this.id,
      @required this.amount,
      @required this.cartItems,
      @required this.timeOrdered});
}

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://shopping-app-jacobia.firebaseio.com/orders.json';
    final dateTime = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': dateTime.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList()
        }));

    _orders.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        amount: total,
        cartItems: cartProducts,
        timeOrdered: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
