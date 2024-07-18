import 'package:finance/resource/drawer.dart';
import 'package:finance/view/screens/auth/loginScreen.dart';
import 'package:finance/view/screens/profile/profileScreen.dart';
import 'package:finance/view/screens/wallet/walletScreen.dart';
import 'package:finance/view/screens/withdrawalListScreen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final List<DrawerItemData> drawerItems;

  const CustomDrawer({
    Key? key,
    required this.drawerItems,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 50,
          ),
          for (var item in widget.drawerItems)
            Container(
              decoration: BoxDecoration(
                  // color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                dense: true,
                leading: Icon(
                  item.icon,
                  size: 20,
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15,
                ),
                onTap: item.onTap,
              ),
            ),
        ],
      ),
    );
  }
}

class CustomAppDrawer extends StatefulWidget {
  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  // final user = FirebaseAuth.instance.currentUser;

  // logOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      drawerItems: [
        DrawerItemData(
          title: 'Profile',
          icon: Icons.person,
          onTap: () {
            // Implement Rate Us functionality
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          },
        ),
        DrawerItemData(
          title: "Wallet",
          icon: Icons.account_balance_wallet,
          onTap: () {
             
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WalletScreen()),
            );
          
          },
        ),
        DrawerItemData(
          title: 'Withdrawal list',
          // icon: Icons.swap_horiz,
          icon: Icons.attach_money,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WithdrawalListScreen()),
            );
          },
        ),
        // DrawerItemData(
        //   title: 'Transaction',
        //   icon: Icons.swap_horiz,
        //   onTap: () {
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => WithdrawalListScreen()),
        //     // );
        //   },
        // ),
        DrawerItemData(
          title: 'Settings',
          icon: Icons.settings,
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SettingScreen()),
            // );
          },
        ),
        DrawerItemData(
          title: 'Referrals',
          icon: Icons.share,
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => OfferScreen()),
            // );
            // Implement Rate Us functionality
          },
        ),
        DrawerItemData(
          title: 'Log Out',
          icon: Icons.logout,
          onTap: () {
            // logOut();
            // Implement Log Out functionality

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 124, 251)),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Perform logout logic here
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );

                        // Close the dialog
                        // Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Logout",
                        style:
                            TextStyle(color: Color.fromARGB(255, 61, 124, 251)),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
