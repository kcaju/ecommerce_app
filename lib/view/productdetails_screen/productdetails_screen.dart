import 'package:ecommerce_app/controller/cartscreen_controller.dart';
import 'package:ecommerce_app/controller/productdetail_screen_controller.dart';
import 'package:ecommerce_app/utils/animation_constants.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:ecommerce_app/view/addtocart_screen/addtocart_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ProductdetailsScreen extends StatefulWidget {
  const ProductdetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductdetailScreenController>()
            .getProductDetails(id: widget.id.toString());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: Consumer<ProductdetailScreenController>(
        builder: (context, prodProv, child) => SingleChildScrollView(
          child: Column(
            children: [
              prodProv.isLoading
                  ? Center(
                      child: Lottie.asset(AnimationConstants.loading,
                          repeat: false, height: 500),
                    )
                  : Container(
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: ColorConstants.black,
                                      size: 30,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.favorite_outline_sharp,
                                    color: ColorConstants.black,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                              prodProv.productDetailObj?.image ?? "",
                              height: 400,
                            )
                          ],
                        ),
                      ),
                      height: 500,
                      decoration: BoxDecoration(
                          color: ColorConstants.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                    ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            prodProv.productDetailObj?.title ?? "",
                            style: TextStyle(
                                color: ColorConstants.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Details :",
                      style: TextStyle(
                          color: ColorConstants.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      prodProv.productDetailObj?.description ?? "",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 18),
                            ),
                            Text(
                              "\$ ${prodProv.productDetailObj?.price ?? ""}",
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 18),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rate",
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 18),
                            ),
                            Text(
                              (prodProv.productDetailObj?.rating?.rate ?? 0.0)
                                  .toString(),
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 16),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Count",
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 18),
                            ),
                            Text(
                              (prodProv.productDetailObj?.rating?.count ?? 0.0)
                                  .toString(),
                              style: TextStyle(
                                  color: ColorConstants.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<CartscreenController>()
                            .addToCart(
                                title: prodProv.productDetailObj?.title ?? "",
                                price: prodProv.productDetailObj?.price ?? 0,
                                des: prodProv.productDetailObj?.description,
                                id: prodProv.productDetailObj?.id,
                                context: context,
                                image: prodProv.productDetailObj?.image ?? "")
                            .then(
                          (value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddtocartScreen(),
                                ));
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.black,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: ColorConstants.black,
                              size: 30,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
