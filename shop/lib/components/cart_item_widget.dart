import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem? cartItem;
  const CartItemWidget({
    Key? key,
    this.cartItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem!.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Tem Certeza ?'),
              content: Text('Quer remover o item do carrinho'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                    child: Text('Não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                    child: Text('Sim')),
              ],
            ));
      },
      onDismissed: (_) {
        Provider.of<Cart>(context,
            listen: false).removeItems(cartItem!.productId!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem!.price!}'),
                ),
              ),
            ),
            title: Text(cartItem!.name!),
            subtitle: Text('Total: R\$ ${cartItem!.price! * cartItem!.quantity!}'),
            trailing: Text('${cartItem!.quantity!}x'),
          ),
        ),
      ),
    );
  }
}
