// import 'dart:convert';
// import 'package:finance/view/widgets/toaster.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class AcoountDetailScreen extends StatefulWidget {
//   const AcoountDetailScreen({super.key});

//   @override
//   State<AcoountDetailScreen> createState() => _AcoountDetailScreenState();
// }

// class _AcoountDetailScreenState extends State<AcoountDetailScreen> {
//   final TextEditingController _holderNameController = TextEditingController();
//   final TextEditingController _accNumberController = TextEditingController();
//   final TextEditingController _ifscCodeController = TextEditingController();

//   Future<void> _submitData() async {
//     final String apiUrl = "http://localhost:5000/v1/bankDetail/addBankDetail";
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({
//         'HolderName': _holderNameController.text,
//         'AccNumber': _accNumberController.text,
//         'IFSCCode': _ifscCodeController.text,
//       }),
//     );
//     print(response.body);
//     String responseBody = await response.body;
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var responseData = json.decode(responseBody);
//       String message = responseData['message'];
//       showToast(message, Colors.green);

//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text('Bank details submitted successfully!')),
//       // );
//     } else {
//       var responseData = json.decode(responseBody);
//       String message = responseData['error'];
//       showToast(message, Colors.green);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to submit bank details')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 25, 29, 65),
//         title: Text(
//           "Account Details",
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.white, // Set the drawer icon color to white
//         ), // Add a title if needed
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: _holderNameController,
//             decoration: InputDecoration(labelText: 'Account Holder Name'),
//           ),
//           TextField(
//             controller: _accNumberController,
//             decoration: InputDecoration(labelText: 'Account Number'),
//             keyboardType: TextInputType.number,
//           ),
//           TextField(
//             controller: _ifscCodeController,
//             decoration: InputDecoration(labelText: 'IFSC Code'),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _submitData,
//             child: Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }
// }
