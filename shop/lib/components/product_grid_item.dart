import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/auth.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                  onPressed: () {
                    product.toggleFavorite(auth.token ?? '', auth.userId ?? '');
                  },
                  icon: Icon(product.isFavorite! ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            title: Text(
              product.name!,
              textAlign: TextAlign.center,
            ),
            trailing:
                IconButton
                  (onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Produto adicionado com sucesso!'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                          label: 'DESFAZER',
                          onPressed: () {
                            cart.removeSingleItem(product.id!);
                          }
                      ),
                    )
                    );
                    cart.addItem(product);
                },
                    icon: Icon(Icons.shopping_cart),
                    color: Theme.of(context).colorScheme.secondary,
                )),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product
            );
          },
        ),
      ),
    );
  }
}
