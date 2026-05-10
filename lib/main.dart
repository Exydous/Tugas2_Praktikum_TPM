import 'package:belajar_getx/bindings/cart_binding.dart';
import 'package:belajar_getx/bindings/product_binding.dart';
import 'package:belajar_getx/views/pages/cart_page.dart';
import 'package:belajar_getx/views/pages/product_detail_page.dart';
import 'package:belajar_getx/views/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/product",
      getPages: [
        GetPage(
          name: "/product",
          page: () => ProductPage(),
          binding: ProductBinding(),
        ),

        GetPage(
          name: "/cart",
          page: () => const CartPage(),
          binding: CartBinding(),
        ),

        GetPage(name: "/detail", page: () => ProductDetailPage()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
