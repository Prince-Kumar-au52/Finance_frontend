import 'package:finance/view/screens/addFund/addMoneyScreen.dart';
import 'package:finance/view/screens/auth/splashScreen.dart';
import 'package:finance/view/screens/home/footerWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Finance',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home:
            //  AddFund(),
            // SignupScreen(),
            //  HomeScreen(),
            SplashScreen()
            );
  }
}
