import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text('Keranjang masih kosong'));
        }

        final cartList = controller.cartItems.values.toList();

        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem = cartList[index];
            final product = cartItem.product;

            double itemSubtotal = product.price * cartItem.quantity.value;
            
            return ListTile(
              title: Text(
                product.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${product.price}  x  ${cartItem.quantity.value}'),
                    const SizedBox(height: 4),
                    Text(
                      'Total: \$${itemSubtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.grey),
                    tooltip: 'Hapus Barang',
                    onPressed: () {
                      controller.removeProduct(product);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () => controller.decreaseQuantity(product),
                  ),
                  Text(
                    '${cartItem.quantity.value}', 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                    onPressed: () => controller.addProduct(product),
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${controller.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        )),
      ),
    );
  }
}