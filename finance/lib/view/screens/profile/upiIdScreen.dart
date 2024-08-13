import 'dart:convert';
import 'package:finance/view/screens/profile/editScreen.dart';
import 'package:finance/view/widgets/toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UPIIdScreen extends StatefulWidget {
  const UPIIdScreen({super.key});

  @override
  State<UPIIdScreen> createState() => _UPIIdScreenState();
}

class _UPIIdScreenState extends State<UPIIdScreen> {
  final TextEditingController _upiIdController = TextEditingController();

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  String? _extractUserIdFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken[
          '_id']; // Adjust the key based on your token structure
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }

  Future<void> _submitData() async {
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
      return;
    }
    String? userId = _extractUserIdFromToken(token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print("=========================$token");
    print('User ID============================: $userId');
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://finance-075c.onrender.com/v1/upiDetail/addUPIDetail'));
    request.body = json.encode({"UpiId": _upiIdController.text});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var responseData = json.decode(responseBody);
      String message = responseData['message']; // Extract the message
      // String userId = responseData['_id'];

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      print('User ID: $userId');
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      var responseData = json.decode(responseBody);
      String message = responseData['error']; // Extract the message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _editUPI() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "UPI ID",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editUPI,
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _upiIdController,
              decoration: const InputDecoration(
                labelText: 'UPI ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
