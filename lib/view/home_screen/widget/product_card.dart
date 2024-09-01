import 'package:ecommerce_app/controller/cartscreen_controller.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key, required this.title, required this.price, required this.img});
  final String title, img;
  final num price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                height: 300,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$ ${widget.price}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.peac,
                ),
              ),
            ),
            Card(
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                    color: ColorConstants.blue,
                    image: DecorationImage(
                        fit: BoxFit.contain, image: NetworkImage(widget.img)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
              ),
            ),
            Positioned(
              top: 20,
              right: 30,
              child: Icon(
                Icons.favorite,
                color: ColorConstants.green,
                size: 30,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  context.read<CartscreenController>().addToCart(
                      title: widget.title,
                      price: widget.price,
                      image: widget.img);
                },
                child: Container(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Add to cart",
                      style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(60, 50),
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: ColorConstants.red),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
