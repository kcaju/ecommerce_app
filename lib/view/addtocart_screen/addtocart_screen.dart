import 'package:ecommerce_app/controller/cartscreen_controller.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddtocartScreen extends StatefulWidget {
  const AddtocartScreen(
      {super.key,
      required this.title,
      required this.qty,
      required this.price,
      this.onIncrement,
      this.ondecrement,
      this.onRemove});
  final String title;
  final String qty;
  final num price;
  final VoidCallback? onIncrement;
  final VoidCallback? ondecrement;
  final VoidCallback? onRemove;

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
          final cartItems = cartProv.cartBox.keys.toList();
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
                              return Card(
                                color: ColorConstants.blue,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(cartProv
                                                        .cartBox
                                                        .get(cartItems[index])!
                                                        .image ??
                                                    "")),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConstants.green),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cartProv.cartBox
                                                    .get(cartItems[index])!
                                                    .title,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        ColorConstants.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "\$ ${cartProv.cartBox.get(cartItems[index])!.price.toString()}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: ColorConstants.black),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed:
                                                          widget.ondecrement,
                                                      child: Icon(
                                                        Icons.remove,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      widget.qty,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: ColorConstants
                                                              .black),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed:
                                                          widget.onIncrement,
                                                      child: Icon(
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            CartscreenController>()
                                                        .remove(index: index);
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        ColorConstants.grey,
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: ColorConstants.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: cartItems.length),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 80,
                  child: Row(
                    children: [
                      Text(
                        "Amount",
                        style: TextStyle(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: ColorConstants.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: ColorConstants.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Checkout",
                              style: TextStyle(
                                color: ColorConstants.white,
                              ),
                            )
                          ],
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
