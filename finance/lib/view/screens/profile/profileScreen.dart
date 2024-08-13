import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance/view/screens/profile/upiIdScreen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentUPIId = "";
  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      body: Material(
        elevation: 8,
        child: ListTile(
          leading: const Text(
            'UPI ID',
            style: TextStyle(fontSize: 22),
          ),
          title: Text(currentUPIId),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UPIIdScreen()),
            );
          },
        ),
      ),
    );
  }
}
