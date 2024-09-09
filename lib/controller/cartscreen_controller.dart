import 'package:ecommerce_app/model/cart_screen/cart_model.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartscreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List keys = [];
  Future<void> addToCart(
      {required String title,
      BuildContext? context,
      String? des,
      num? id,
      int qty = 1,
      String? image,
      required num price}) async {
    bool alreadyinCart = false;
//to check whether  the item is already in cart(hive)
    for (int i = 0; i < keys.length; i++) {
      //checking whether the id of added item is in hive(use get fnct)
      var iteminHive = cartBox.get(keys[i]);
      if (iteminHive?.id == id) {
        alreadyinCart = true;
      }
    }
    if (alreadyinCart == false) {
      await cartBox.add(CartModel(
          price: price,
          title: title,
          qty: qty,
          image: image,
          des: des,
          id: id));
      keys = cartBox.keys.toList();
    } else {
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: ColorConstants.orange,
          duration: Duration(seconds: 3),
          content: Text(
            "Item Already Added",
            style: TextStyle(
                color: ColorConstants.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )));
    }
    notifyListeners();
  }

  removeItem(var key) async {
    await cartBox.delete(key);
    keys = cartBox.keys.toList();
    notifyListeners();
  }

  incrementQnty(var key) {
    final currentItemData = cartBox.get(key);
    cartBox.put(
        key,
        CartModel(
          price: currentItemData!.price,
          title: currentItemData.title,
          id: currentItemData.id,
          image: currentItemData.image,
          des: currentItemData.des,
          qty: ++currentItemData.qty,
        ));
    notifyListeners();
  }

  decrementQnty(var key) {
    final currentItemData = cartBox.get(key);
    if (currentItemData!.qty >= 2) {
      cartBox.put(
          key,
          CartModel(
            price: currentItemData.price,
            title: currentItemData.title,
            id: currentItemData.id,
            image: currentItemData.image,
            des: currentItemData.des,
            qty: --currentItemData.qty,
          ));
    }
    notifyListeners();
  }

  getAllCartItems() {
    keys = cartBox.keys.toList();
    notifyListeners();
  }

//for getting the current item
  CartModel? getCurrentItem(var key) {
    final currentItem = cartBox.get(key);
    return currentItem;
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    for (int i = 0; i < keys.length; i++) {
      final item = cartBox.get(keys);
      if (item != null) {
        totalAmount += item.price * item.qty;
      }
    }
    notifyListeners();
    return totalAmount;
  }
}
