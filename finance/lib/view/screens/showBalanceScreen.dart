import 'package:flutter/material.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text("Balance",
          style: TextStyle(color: Colors.white),
        ),
       iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ), 
      ),
    );
  }
}