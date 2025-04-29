import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/counter_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'models/product_list.dart';
import 'utils/app_routes.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
              seedColor: Colors.deepOrange
             ),
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
            centerTitle: true
          )
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

