import 'package:get/get.dart';
import '../models/product.dart';

class CartItem {
  Product product;
  RxInt quantity;
  
  CartItem({required this.product, int initialQty = 1}) : quantity = initialQty.obs;
}

class CartController extends GetxController {

  var cartItems = <String, CartItem>{}.obs;

  int getProductQuantity(Product product) {
    if (cartItems.containsKey(product.title)) {
      return cartItems[product.title]!.quantity.value;
    }
    return 0;
  }

  void addProduct(Product product){
    if (cartItems.containsKey(product.title)) {
      cartItems[product.title]!.quantity.value++;
      cartItems.refresh();
    } else {
      cartItems[product.title] = CartItem(product: product, initialQty: 1);
    }
  }

  void decreaseQuantity(Product product) {
    if (cartItems.containsKey(product.title)) {
      if (cartItems[product.title]!.quantity.value > 1) {
        cartItems[product.title]!.quantity.value--;
        cartItems.refresh();
      } else {
        cartItems.remove(product.title);
      }
    }
  }

  void removeProduct(Product product) {
    cartItems.remove(product.title);
  }

  double get totalPrice{
    double total = 0;
    cartItems.forEach((key, item) {
      total += (item.product.price * item.quantity.value);
    });
    return total;
  }

  int get itemCount {
    int count = 0;
    cartItems.forEach((key, item) {
      count += item.quantity.value;
    });
    return count;
  }
}