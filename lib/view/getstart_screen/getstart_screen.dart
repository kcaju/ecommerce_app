import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:ecommerce_app/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class GetstartScreen extends StatelessWidget {
  const GetstartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: ColorConstants.blue,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.pexels.com/photos/683404/pexels-photo-683404.jpeg?auto=compress&cs=tinysrgb&w=600"))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "illuminate",
                style: TextStyle(color: ColorConstants.white, fontSize: 40),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "Your Style",
                    style: TextStyle(color: ColorConstants.peac, fontSize: 40),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Container(
                      height: 60,
                      width: 200,
                      child: Center(
                        child: Text(
                          "shop Now",
                          style: TextStyle(
                              color: ColorConstants.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(60, 30),
                              bottomLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: ColorConstants.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
