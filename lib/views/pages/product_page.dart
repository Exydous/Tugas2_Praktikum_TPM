import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../views/widgets/product_card.dart';
import '../../controllers/cart_controller.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {

    final CartController cartC = Get.put(CartController(), permanent: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Home Page'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed("/cart"); 
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Obx(() {
                  if (cartC.itemCount == 0) return const SizedBox.shrink();
                  
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartC.itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 10, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(width: 8), 
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          if (controller.isLoading) { 
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueGrey),
            );
          }
          return GridView.builder(
            itemCount: controller.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: controller.products[index],
                onTap: () {
                  Get.toNamed("/detail", arguments: controller.products[index]);
                },
              );
            },
          );
        }),
      ),
    );
  }
}