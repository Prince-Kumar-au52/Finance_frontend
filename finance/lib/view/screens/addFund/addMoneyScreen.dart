import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddFund extends StatefulWidget {
  const AddFund({Key? key}) : super(key: key);

  @override
  State<AddFund> createState() => _AddFundState();
}

class _AddFundState extends State<AddFund> {
  TextEditingController amountController = TextEditingController();

//   Future<void> addFund() async {
//     // if (amountController.text.isEmpty) {
//     //   // Show an error if the amount is empty
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     const SnackBar(
//     //         content: Text('Amount is required',
//     //             style: TextStyle(color: Colors.red))),
//     //   );
//     //   return;
//     // }

// var request = http.Request('GET', Uri.parse('https://finance-075c.onrender.com/pay'));
//     // request.body = json.encode({"amount": amountController.text});
//     var headers = {'Content-Type': 'application/json'};
//     // var request = http.Request('POST', Uri.parse('http://localhost:5000/pay'));
//     // request.body = json.encode({"amount": amountController.text});
//     request.headers.addAll(headers);

//     try {
//       http.StreamedResponse response = await request.send();

//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         var responseData = json.decode(responseBody);

//         // Extract and print the message from the response
//         String message = responseData['message'];
//         print("Success: $message");

//         // Display a toast or dialog with the message (optional)
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(message, style: const TextStyle(color: Colors.green))),
//         );
//       } else {
//         String responseBody = await response.stream.bytesToString();
//         var responseData = json.decode(responseBody);

//         // Extract and print the error message from the response
//         String errorMessage = responseData['error'] ?? 'Unknown error';
//         print("Error: $errorMessage");

//         // Display a toast or dialog with the error message (optional)
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(errorMessage, style: const TextStyle(color: Colors.red))),
//         );
//       }
//     } catch (e) {
//       print('===============Error sending request: $e');

//       // Display a toast or dialog with the error message (optional)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//             content: Text('Error: $e', style: const TextStyle(color: Colors.red))),
//       );
//     }
//   }

  void fetchData() async {
    var url = Uri.parse('https://finance-075c.onrender.com/pay');
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // Process responseData as needed
        print('Response data: $responseData');
      } else {
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
                // addFund();
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
