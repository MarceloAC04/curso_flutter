import 'package:flutter/material.dart';
import 'package:shop/components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Minha Loja',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ProductGrid());
  }
}
