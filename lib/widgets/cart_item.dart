import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carts_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  const CartItem({this.id, this.price, this.quantity, this.title, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 4,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartsProvider>(
          context,
          listen: false,
        ).removeItem(productId);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$title removed!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
      confirmDismiss: (direction) async {
        return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content: const Text("Are you sure you wish to delete this item?"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("DELETE")),
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL"),
                  ),
                ],
              );
            });
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: FittedBox(child: Text('\$$price')),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total: \$${price * quantity}'),
              trailing: Text('Quantity: ${quantity}x')),
        ),
      ),
    );
  }
}
