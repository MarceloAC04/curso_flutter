import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product? product;

  const ProductItem({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product!.imageUrl!),
      ),
      title: Text(product!.name!),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCTS_FORM,
                    arguments: product,
                  );
                },
                color: Theme.of(context).colorScheme.primary,
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            title: Text('Tem Certeza ?'),
                            content: Text('Quer remover o produto ${product!.name} da loja!'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: Text('Não')),
                              TextButton(
                                  onPressed: () {
                                    Provider.of<ProductList>(context,
                                            listen: false)
                                        .removeProduct(product!);
                                    Navigator.of(ctx).pop(false);
                                  },
                                  child: Text('Sim')),
                            ],
                          ));
                },
                color: Theme.of(context).colorScheme.error,
                icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
