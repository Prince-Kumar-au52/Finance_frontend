import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalListScreen extends StatefulWidget {
  const WithdrawalListScreen({super.key});

  @override
  State<WithdrawalListScreen> createState() => _WithdrawalListScreenState();
}

class _WithdrawalListScreenState extends State<WithdrawalListScreen> {
  List<Map<String, dynamic>> withdrawalData = [];

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _fetchWithdrawals() async {
    String? token = await _getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Error: No token found. Please log in again.")),
      );
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse('https://finance-075c.onrender.com/v1/withDrow/getWithdrowforUser'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        withdrawalData = List<Map<String, dynamic>>.from(responseData['data']);
      });
    } else {
      print(response.reasonPhrase);
      var responseData = json.decode(response.body);
      String message = responseData['error']; // Extract the message

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWithdrawals(); // Fetch withdrawals when the screen initializes
  }

  Color _getStatusColor(Map<String, dynamic> withdrawal) {
    if (withdrawal['IsRejected'] == true) {
      return Colors.red;
    } else if (withdrawal['IsVerify'] == true) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  Color _getCompletionColor(Map<String, dynamic> withdrawal) {
    if (withdrawal['IsComleted'] == true && withdrawal['IsVerify'] == true) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  String _getStatus(Map<String, dynamic> withdrawal) {
    if (withdrawal['IsRejected'] == true) {
      return 'Rejected';
    } else if (withdrawal['IsVerify'] == true) {
      return 'Verified';
    } else {
      return 'Pending';
    }
  }

  String _getComleted(Map<String, dynamic> withdrawal) {
    if (withdrawal['IsComleted'] == true && withdrawal['IsVerify'] == true) {
      return 'Completed';
    } else {
      return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "Withdrawal List",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text('Amount',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Request Verification',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Complete',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: withdrawalData.map((withdrawal) {
                    return DataRow(cells: [
                      DataCell(Text(withdrawal['CreatedDate']
                          .split('T')
                          .first)), // Format the date
                      DataCell(Text(withdrawal['Amount'].toString())),
                      DataCell(
                        Text(
                          _getStatus(withdrawal),
                          style: TextStyle(color: _getStatusColor(withdrawal)),
                        ),
                      ),
                      DataCell(
                        Text(
                          _getComleted(withdrawal),
                          style:
                              TextStyle(color: _getCompletionColor(withdrawal)),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
