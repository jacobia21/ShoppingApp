import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carts_provider.dart' show CartsProvider;
import '../widgets/cart_item.dart';
import '../providers/orders_provider.dart';

class CartsScreen extends StatelessWidget {
  static const routeName = ('/cart');
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Cart',
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cartData.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).primaryTextTheme.headline6.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<OrdersProvider>(
                          context,
                          listen: false,
                        ).addOrder(
                          cartData.items.values.toList(),
                          cartData.totalAmount,
                        );
                        cartData.clearCart();
                      },
                      child: Text('Order Now',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartData.items.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    id: cartData.items.values.toList()[index].id,
                    title: cartData.items.values.toList()[index].title,
                    quantity: cartData.items.values.toList()[index].quantity,
                    price: cartData.items.values.toList()[index].price,
                    productId: cartData.items.keys.toList()[index],
                  );
                },
              ),
            )
          ],
        ));
  }
}
