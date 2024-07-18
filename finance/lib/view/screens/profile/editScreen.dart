import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          "UPI ID",
          style: TextStyle(color: Colors.white),
        ),
       
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ), // Add a title if needed
      ),
      body: const Center(
        child: Text("This is the edit screen"),
      ),
    );
  }
}
