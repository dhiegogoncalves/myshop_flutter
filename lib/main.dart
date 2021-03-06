import 'package:flutter/material.dart';
import 'package:myshop_flutter/providers/auth.dart';
import 'package:myshop_flutter/providers/cart.dart';
import 'package:myshop_flutter/providers/orders.dart';
import 'package:myshop_flutter/providers/products.dart';
import 'package:myshop_flutter/utils/app_routes.dart';
import 'package:myshop_flutter/utils/custom_route.dart';
import 'package:myshop_flutter/views/auth_home_screen.dart';
import 'package:myshop_flutter/views/cart_screen.dart';
import 'package:myshop_flutter/views/orders_screen.dart';
import 'package:myshop_flutter/views/product_detail_screen.dart';
import 'package:myshop_flutter/views/product_form_screen.dart';
import 'package:myshop_flutter/views/products_overview_screen.dart';
import 'package:myshop_flutter/views/products_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env_dev');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, auth, previousProducts) =>
              Products(auth.token, auth.userId, previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (ctx, auth, previousOrders) =>
              Orders(auth.token, auth.userId, previousOrders.items),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionsBuilder(),
              TargetPlatform.iOS: CustomPageTransitionsBuilder(),
            },
          ),
        ),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.HOME: (ctx) => ProductsOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
          AppRoutes.ORDERS: (ctx) => OrdersScreen(),
          AppRoutes.PRODUCTS: (ctx) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (ctx) => ProductFormScreen(),
        },
      ),
    );
  }
}
