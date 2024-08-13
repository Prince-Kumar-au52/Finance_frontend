import 'package:finance/view/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  late Future<List<dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
    }

    final url =
        'http://localhost:5000/v1/wallet/getWalletforUser'; // Replace with your local IP address

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonData['success']) {
          final dataList = jsonData['data'] as List;
          return dataList;
        } else {
          throw Exception('Data fetch unsuccessful');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Display'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('There is no data.'));
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final response = item['response']['data'];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Transaction ID: ${item['transactionId']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Code: ${item['code']}'),
                        Text('Amount: ${item['Amount']}'),
                        Text('Created Date: ${item['CreatedDate']}'),
                        Text('Merchant ID: ${response['merchantId']}'),
                        Text('Amount (response): ${response['amount']}'),
                        Text('State: ${response['state']}'),
                        Text(
                            'Payment Instrument Type: ${response['paymentInstrument']['type']}'),
                        Text(
                            'Card Type: ${response['paymentInstrument']['cardType']}'),
                        Text('ARN: ${response['paymentInstrument']['arn']}'),
                        Text('BRN: ${response['paymentInstrument']['brn']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
