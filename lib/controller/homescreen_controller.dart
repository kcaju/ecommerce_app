import 'dart:convert';

import 'package:ecommerce_app/model/homescreen/product_res_model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomescreenController with ChangeNotifier {
  List<ProductResModel> dataObj = [];
  List categoryList = ["All"];
  bool isCategoryLoading = false;
  bool isProductLoading = false;
  int selectedCategoryIndex = 0;

  Future<void> getAllProducts({String category = ''}) async {
    isProductLoading = true;
    notifyListeners();
    try {
      final allurl = Uri.parse("https://fakestoreapi.com/products");
      final categoryurl =
          Uri.parse("https://fakestoreapi.com/products/category/$category");
      final url = category.isEmpty ? allurl : categoryurl;
      var productData = await http.get(url);
      print(productData.statusCode);
      if (productData.statusCode == 200) {
        dataObj = productResModelFromJson(productData.body);
        // print(dataObj[0].title);
      }
    } catch (e) {
      print(e);
    }
    isProductLoading = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    isCategoryLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse("https://fakestoreapi.com/products/categories");
      var resp = await http.get(url);
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        categoryList.addAll(jsonDecode(resp.body));
      }
    } catch (e) {
      print(e);
    }
    isCategoryLoading = false;
    notifyListeners();
  }

  void getProductByCategory() {}
  void getCategoryIndex(int index) {
    selectedCategoryIndex = index;
    if (selectedCategoryIndex == 0) {
      getAllProducts();
    } else {
      getAllProducts(category: categoryList[selectedCategoryIndex]);
    }
    notifyListeners();
  }
}
