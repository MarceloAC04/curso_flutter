import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart_item.dart';
import '../utils/constants.dart';
import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  final String? _token;
  final String? _userId;
  List<Order> _items = [];

  OrderList([
    this._token = '',
    this._userId,
    this._items = const [],
  ]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> items = [];

    final response = await http.get(Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'));
    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.body == 'null') return;
    data.forEach((orderId, orderData) {
      items.add(
          Order(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            total: orderData['total'],
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                quantity: item['quantity'],
                price: item['price'],
              );
            }).toList(),
          )
      );
    });

    _items = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse('${Constants.ORDER_BASE_URL}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values.map(
            (cartItem) => {
              'id': cartItem.id,
              'productId': cartItem.productId,
              'name': cartItem.name,
              'quantity': cartItem.quantity,
              'price': cartItem.price,
            },
          ).toList(),
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
