import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> wallet;

  DetailScreen({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 25, 29, 65),
         iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction ID: ${wallet['transactionId']}',
                  style: TextStyle(fontSize: 18)),
              Text('Amount: ${wallet['Amount']}',
                  style: TextStyle(fontSize: 18)),
              Text('Merchant ID: ${wallet['merchantId']}',
                  style: TextStyle(fontSize: 18)),
              Text('Provider Reference ID: ${wallet['providerReferenceId']}',
                  style: TextStyle(fontSize: 18)),
              Text('Created Date: ${wallet['CreatedDate']}',
                  style: TextStyle(fontSize: 18)),
              Text('Response: ${wallet['response']['message']}',
                  style: TextStyle(fontSize: 18)),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
