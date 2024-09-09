import 'package:ecommerce_app/controller/cartscreen_controller.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:ecommerce_app/view/addtocart_screen/widget/cartsitem_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddtocartScreen extends StatefulWidget {
  const AddtocartScreen({
    super.key,
  });

  @override
  State<AddtocartScreen> createState() => _AddtocartScreenState();
}

class _AddtocartScreenState extends State<AddtocartScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<CartscreenController>().getAllCartItems();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.black,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: ColorConstants.white,
          ),
        ),
        title: Text(
          "My Cart",
          style: TextStyle(color: ColorConstants.white),
        ),
      ),
      body: Consumer<CartscreenController>(
        builder: (context, cartProv, child) {
          final totalAmount = cartProv.calculateTotalAmount();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final cartItem =
                                  cartProv.getCurrentItem(cartProv.keys[index]);
                              return CartsitemWidget(
                                title: cartItem?.title.toString() ?? "",
                                qty: cartItem?.qty.toString() ?? "",
                                price: cartItem?.price ?? 0,
                                image: cartItem?.image.toString() ?? "",
                                onDecrement: () {
                                  context
                                      .read<CartscreenController>()
                                      .decrementQnty(cartProv.keys[index]);
                                },
                                onIncrement: () {
                                  context
                                      .read<CartscreenController>()
                                      .incrementQnty(cartProv.keys[index]);
                                },
                                onRemove: () {
                                  context
                                      .read<CartscreenController>()
                                      .removeItem(cartProv.keys[index]);
                                },
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: cartProv.keys.length),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  height: 80,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total :",
                            style: TextStyle(
                                color: ColorConstants.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          Text(
                            "\$ ${totalAmount.toStringAsFixed(2)}",
                            style: TextStyle(
                                color: ColorConstants.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: ColorConstants.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: ColorConstants.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
