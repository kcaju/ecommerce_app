import 'package:ecommerce_app/model/productdetail_screen/productdetails_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductdetailScreenController with ChangeNotifier {
  ProductsDetailsModel? productDetailObj;
  bool isLoading = false;
  Future<void> getProductDetails({required String id}) async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/$id");
      var res = await http.get(url);
      print(res.statusCode);
      if (res.statusCode == 200) {
        productDetailObj = productsDetailsModelFromJson(res.body);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
