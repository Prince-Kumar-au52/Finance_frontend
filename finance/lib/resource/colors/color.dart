import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorSelect {
  static Color getWhiteColor() {
    return Get.isDarkMode ? Colors.black : Colors.white;
  }

  static Color getGreyColor() {
    return Get.isDarkMode
        ? Colors.black
        : const Color.fromARGB(255, 238, 238, 238);
  }

  static LinearGradient getGradientAppbarColor() {
    return !Get.isDarkMode
        ? const LinearGradient(colors: [
            Color.fromARGB(255, 25, 139, 29),
            Colors.yellow,
          ])
        : const LinearGradient(colors: [Colors.black, Colors.grey]);
  }

  static const LinearGradient loginGradient = LinearGradient(colors: [
    Color.fromARGB(255, 25, 139, 29),
    Colors.yellow,
  ]);

  static LinearGradient sumbitGrdient =
      const LinearGradient(colors: [Colors.black, Colors.grey]);

  Color whiteColor = getWhiteColor();
  Color greyColor = getGreyColor();
  Color greenColor = const Color.fromARGB(255, 7, 177, 7);
  Color blueColor = Color.fromARGB(255, 71, 49, 167);
  Color yellowColor = const Color.fromARGB(255, 245, 197, 4);
  // Color blackColor = const Color.fromARGB(255, 11, 11, 11);
}
