import 'package:ecommerce_app/controller/homescreen_controller.dart';
import 'package:ecommerce_app/utils/animation_constants.dart';
import 'package:ecommerce_app/utils/color_constants.dart';
import 'package:ecommerce_app/view/addtocart_screen/addtocart_screen.dart';
import 'package:ecommerce_app/view/home_screen/widget/product_card.dart';
import 'package:ecommerce_app/view/productdetails_screen/productdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomescreenController>().getCategories();
        await context.read<HomescreenController>().getAllProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProv = context.watch<HomescreenController>();
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        backgroundColor: ColorConstants.black,
        leading: Icon(
          Icons.sort,
          color: ColorConstants.white,
          size: 30,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddtocartScreen(),
                  ));
            },
            child: Icon(
              Icons.shopping_bag_outlined,
              color: ColorConstants.white,
              size: 30,
            ),
          )
        ],
      ),
      body: homeProv.isCategoryLoading
          ? Center(
              child: Lottie.asset(AnimationConstants.loading,
                  repeat: false, height: 300),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: ColorConstants.white,
                        filled: true,
                        hintText: "Search",
                        hintStyle: TextStyle(color: ColorConstants.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConstants.grey,
                          size: 30,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      homeProv.categoryList.length,
                      (index) => InkWell(
                        onTap: () {
                          context
                              .read<HomescreenController>()
                              .getCategoryIndex(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            homeProv.categoryList[index]
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    index == homeProv.selectedCategoryIndex
                                        ? ColorConstants.white
                                        : ColorConstants.black,
                                color: index == homeProv.selectedCategoryIndex
                                    ? ColorConstants.white
                                    : ColorConstants.grey,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                homeProv.isProductLoading
                    ? Center(
                        child: Lottie.asset(AnimationConstants.loading,
                            repeat: false, height: 500),
                      )
                    : Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: homeProv.dataObj.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 350,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductdetailsScreen(
                                        id: homeProv.dataObj[index].id!,
                                      ),
                                    ));
                              },
                              child: ProductCard(
                                  id: homeProv.dataObj[index].id,
                                  title:
                                      homeProv.dataObj[index].title.toString(),
                                  price: homeProv.dataObj[index].price ?? 0,
                                  img:
                                      homeProv.dataObj[index].image.toString()),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: ColorConstants.white),
                        ),
                      )
              ],
            ),
    );
  }
}
