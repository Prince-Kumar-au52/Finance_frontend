import 'dart:convert';
import 'package:finance/view/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AddFund extends StatefulWidget {
  const AddFund({Key? key}) : super(key: key);

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
  TextEditingController amountController = TextEditingController();
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }


  void fetchData() async {
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var amount = amountController.text;
    var url = Uri.parse('http://localhost:5000/pay?amount=$amount');
    // var headers = {
    //   'Content-Type': 'application/json',
    // };

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // Process responseData as needed
        print('Response data: $responseData');

        // Extract the redirect URL
        if (responseData['success'] == true &&
            responseData.containsKey('redirectUrl')) {
          var redirectUrl = responseData['redirectUrl'];

          // Redirect to the URL
          if (await canLaunch(redirectUrl)) {
            await launch(redirectUrl);
          } else {
            throw 'Could not launch $redirectUrl';
          }
        } else {
          print('No redirect URL found in the response');
        }
      } else {
        var responseBody = response.body;
        var responseData = json.decode(responseBody);
        String message = responseData['error']; // Extract the error message

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "Add Fund",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Input field to add amount
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Enter Amount',
                  prefixText: '₹ ', // Prefix text for Rupee symbol
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Text('Add'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
