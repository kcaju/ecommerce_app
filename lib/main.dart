import 'package:ecommerce_app/controller/cartscreen_controller.dart';
import 'package:ecommerce_app/controller/homescreen_controller.dart';
import 'package:ecommerce_app/controller/productdetail_screen_controller.dart';
import 'package:ecommerce_app/model/cart_screen/cart_model.dart';
import 'package:ecommerce_app/view/getstart_screen/getstart_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<CartModel>(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomescreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductdetailScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartscreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GetstartScreen(),
      ),
    );
  }
}
