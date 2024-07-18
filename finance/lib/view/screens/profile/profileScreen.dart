
import 'package:finance/view/screens/profile/upiIdScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      body: ListView(
        children: [
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Account Details'),
          //   trailing: Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => AcoountDetailScreen()),
          //     );
          //   },
          // ),
          // Divider(), // Add a divider between list tiles if needed
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('UPI ID'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UPIIdScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
