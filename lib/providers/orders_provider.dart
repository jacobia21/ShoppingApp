import 'package:flutter/foundation.dart';

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

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: total,
        cartItems: cartProducts,
        timeOrdered: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
