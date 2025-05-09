import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/CartButton.dart';
import 'package:shop/components/cart_item_widget.dart';

import '../models/cart.dart';
import '../models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Chip(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: Text(
                        'R\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleLarge
                                ?.color),
                      )),
                  Spacer(),
                  CartButton(cart: cart,)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i])),
          ),
        ],
      ),
    );
  }
}
