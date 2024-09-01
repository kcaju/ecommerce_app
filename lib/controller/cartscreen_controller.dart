import 'package:ecommerce_app/model/cart_screen/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartscreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List keys = [];
  addToCart(
      {required String title,
      String? des,
      int qty = 1,
      String? image,
      required num price}) {
    cartBox.add(CartModel(
        price: price, title: title, qty: qty, image: image, des: des));
    notifyListeners();
  }

  remove({int? index}) async {
    await cartBox.delete(keys[index!]);
    notifyListeners();
  }

  incrementQnty() {}
  decrementQnty() {}
  getAllCartItems() {
    keys = cartBox.keys.toList();
    notifyListeners();
  }

  calculateTotalAmount() {}
}
