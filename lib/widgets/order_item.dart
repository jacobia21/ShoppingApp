import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.Order order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.order.cartItems.length * 20.0 + 110, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(DateFormat.yMMMMd().format(widget.order.timeOrdered)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: _expanded ? min(widget.order.cartItems.length * 20.0 + 10, 100) : 0,
              child: ListView(
                children: widget.order.cartItems
                    .map((prod) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${prod.quantity}x \$${prod.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                )),
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
