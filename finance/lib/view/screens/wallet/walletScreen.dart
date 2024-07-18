import 'dart:convert';

import 'package:finance/view/screens/wallet/walletBalanceWidgetdart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int remainingMoney = 0;
  bool isLoading = true;
  bool isError = false;

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    fetchUserCount();
  }

  Future<void> fetchUserCount() async {
    final url = Uri.parse('https://finance-075c.onrender.com/v1/wallet/getMoney');
    String? token = await _getToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          remainingMoney = data['data']['remainingMoney'];
          isLoading = false;
        });
      } else {
        print(response.reasonPhrase);
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ), // Add a title if needed
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: Container(
                height: 150,
                width: size.width * .9,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Balance",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 98, 98, 98),
                      ),
                    ),
                    Text(
                      "₹$remainingMoney",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10,
                  child: Container(
                    height: 60,
                    width: size.width * .4,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.arrow_circle_up,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Withdrow",
                          // style: TextStyle(
                          //   fontSize: 20,
                          //   fontWeight: FontWeight.bold,
                          //   color: Color.fromARGB(255, 98, 98, 98),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 10,
                  child: Container(
                    height: 60,
                    width: size.width * .4,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.arrow_circle_down,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Receive",
                          // style: TextStyle(
                          // fontSize: 20,
                          // fontWeight: FontWeight.bold,
                          // color: Colors.black,
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Transaction history",
              style: const TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 98, 98, 98),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
