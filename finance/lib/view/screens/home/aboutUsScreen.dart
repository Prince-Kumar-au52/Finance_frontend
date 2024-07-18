import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTePHfCLmV_Q4P1li4wFRX_zEkWPGkwBOmW7w&s',
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 50.0,
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("About Us",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
                "Main achha hoon, shukriya! Main ChatGPT hoon, ek AI bhasha model jo OpenAI ne banaya hai. Mera kaam hai logon ki madad karna unke sawalon ka jawab dekar, samasyaon ko suljha kar, aur naye ideas aur information share karke. Main khud ek machine hoon, isliye mere paas apni personal life ya experiences nahi hote. Lekin main bohot si cheezen janta hoon aur har tarah ki madad dene ke liye yahaan hoon! Aapka aur kuchh puchhna ho to bataye."),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
