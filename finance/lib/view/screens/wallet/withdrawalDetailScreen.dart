import 'package:flutter/material.dart';

class WithdrawalDetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const WithdrawalDetailScreen({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Withdrawal Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 25, 29, 65),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ), // Match app theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Amount: ₹${item['Amount']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Created By: ${item['CreatedBy']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Created Date: ${_formatDate(item['CreatedDate'])}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Completed: ${item['IsComleted'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Verified: ${item['IsVerify'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Rejected: ${item['IsRejected'] ? 'Yes' : 'No'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Updated Date: ${_formatDate(item['UpdatedDate'])}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    // Format date string to a readable format
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
