import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meus Pedidos'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<OrderList>(
              context,
              listen: false,
            ).loadOrders(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              } else if (snapshot.error != null) {
                return const Center(
              child: Text('Ocorreu um erro!'),
              );
              } else {
                return Consumer<OrderList>(
                  builder: (ctx, orders, child) =>
                      ListView.builder(
                        itemCount: orders.itemsCount,
                        itemBuilder: (ctx, i) =>
                            OrderWidget(order: orders.items[i],),
                      ),
                );
              } // body: RefreshIndicator(
            }
        ),
    );
  }
}
