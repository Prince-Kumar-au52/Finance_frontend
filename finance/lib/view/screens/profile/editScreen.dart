import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _upiIdController;
  String currentUPIId = "";

  @override
  void initState() {
    super.initState();
    _upiIdController = TextEditingController();
    _fetchUPIId();
  }

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

  Future<void> _fetchUPIId() async {
    String? token = await _getToken();
    String? userId = _extractUserIdFromToken(token!);
    print("===============$userId");
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://localhost:5000/v1/upiDetail/UPIDetailByUser/$userId'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var responseData = json.decode(responseBody);
      setState(() {
        currentUPIId = responseData['data']['UpiId'];
      });
      print("UPI ID: $currentUPIId");
    } else {
      print("Error: ${response.reasonPhrase}");
    }
  }

  Future<void> _updateUPIId() async {
    String? token = await _getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Error: No token found. Please log in again.")),
      );
      return;
    }
    String? userId = _extractUserIdFromToken(token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request(
        'PATCH',
        Uri.parse(
            "http://localhost:5000/v1/upiDetail/updateUPIDetailByUser/$userId"));
    request.body = json.encode({"UpiId": _upiIdController.text});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var responseData = json.decode(responseBody);
        String message = responseData['message']; // Extract the message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        // Navigator.pop(context);
      } else {
        var responseData = json.decode(responseBody);
        String message = responseData['error']; // Extract the message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred while updating the UPI ID.')),
      );
    }
  }

  // @override
  // void dispose() {
  //   _upiIdController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "Edit UPI ID",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current UPI ID:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              currentUPIId,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _upiIdController,
              decoration: const InputDecoration(
                labelText: 'UPI ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _updateUPIId,
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
