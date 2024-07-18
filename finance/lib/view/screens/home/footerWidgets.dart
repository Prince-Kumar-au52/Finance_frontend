import 'package:finance/view/screens/home/aboutUsScreen.dart';
import 'package:finance/view/screens/home/contactUsScreen.dart';
import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  void _onTileTap(BuildContext context, String title) {
    // Implement your action here, such as navigation or any other functionality
    print('Tapped on: $title');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About Us",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 25, 29, 65)),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text("This and that",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        const Text(
            "Main achha hoon, shukriya! Main ChatGPT hoon, ek AI bhasha model jo OpenAI ne banaya hai. Mera kaam hai logon ki madad karna unke sawalon ka jawab dekar, samasyaon ko suljha kar, aur naye ideas aur information share karke. Main khud ek machine hoon, isliye mere paas apni personal life ya experiences nahi hote. Lekin main bohot si cheezen janta hoon aur har tarah ki madad dene ke liye yahaan hoon! Aapka aur kuchh puchhna ho to bataye."),
        const SizedBox(height: 30),
        const Text("Useful Links",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          leading: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          title: const Text("Contact Us"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
          ),
          title: const Text("About Us"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutUsScreen()),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text("Contact Us",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
        ),
        const ListTile(
          leading: Icon(
            Icons.phone,
            color: Colors.teal,
          ),
          title: Text("6645365885"),
        ),
        const ListTile(
          leading: Icon(
            Icons.email,
            color: Colors.teal,
          ),
          title: Text("Prince@gmail.com"),
        ),
        
      ],
    );
  }
}
