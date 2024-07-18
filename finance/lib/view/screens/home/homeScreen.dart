import 'dart:convert';
import 'package:finance/view/screens/addFund/addMoneyScreen.dart';
import 'package:finance/view/screens/home/returnPolicyScreen.dart';
import 'package:finance/view/screens/wallet/walletScreen.dart';
import 'package:finance/view/screens/withdrawelScreen.dart';
import 'package:finance/view/widgets/drawer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

import 'ShippingPolicyScreen.dart';
import 'Cancellation&RefundPolicy.dart';
import 'faqWidgets.dart';
import 'footerWidgets.dart';
import 'term&ConditionScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imgList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when screen initializes
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://finance-075c.onrender.com/v1/banner/allBanner'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        setState(() {
          imgList = List<String>.from(
              jsonData['data'].map((banner) => banner['Banner']));
        });
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      print('Error fetching banners: $e');
      // Handle error gracefully, show error message or retry option
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ),
      ),
      drawer: CustomAppDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  imgList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: imgList
                              .map(
                                (item) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: size.width,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                  const SizedBox(height: 10),
                  Center(
                    child: CarouselIndicator(
                      count: imgList.length,
                      index: currentIndex,
                      color: Colors.grey,
                      activeColor: Colors.blue,
                      height: 6,
                      width: 6,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMenuItem(
                        text: 'Add Fund',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddFund()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        text: 'Check Balance',
                        icon: Icons.account_balance_wallet,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WalletScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        text: 'Withdrawal',
                        icon: Icons.money_off,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WithdrawScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: size.width,
                    height: 200,
                    child: Image.asset(
                      'assets/faq.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                  FAQWidget(
                    faqList: const [
                      {
                        "question": "What is the return policy?",
                        "answer":
                            "Our return policy allows returns within 30 days of purchase."
                      },
                      {
                        "question": "How do I track my order?",
                        "answer":
                            "You can track your order using the tracking number provided in the confirmation email."
                      },
                      {
                        "question": "Can I change my shipping address?",
                        "answer":
                            "Yes, you can change your shipping address before the order is shipped."
                      },
                      {
                        "question": "What payment methods are accepted?",
                        "answer":
                            "We accept credit/debit cards, PayPal, and bank transfers."
                      },
                    ],
                  ),
                  const SizedBox(height: 20),
                  const FooterSection(),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TermsConditionsScreen()),
                          );
                        },
                        child: const Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShippingPolicyScreen()),
                          );
                        },
                        child: const Text(
                          "Shipping Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CancellationAndRefundPolicyScreen()),
                          );
                        },
                        child: const Text(
                          "Cancellation and Refund Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ReturnsPolicyScreen()),
                          );
                        },
                        child: const Text(
                          "Return Policy",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 25, 29, 65),
              ),
              child: const Center(
                child: Text(
                  "Alles mogelijk service pvt ltd",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 9,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width * 0.27,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQWidget extends StatelessWidget {
  final List<Map<String, String>> faqList;

  FAQWidget({required this.faqList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: faqList.map((faq) {
        return Column(
          children: [
            Container(
              child: ExpansionTile(
                // backgroundColor: Colors.grey[300],
                collapsedBackgroundColor: Colors.grey[200],
                title: Text(
                  faq["question"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(faq["answer"]!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // Add space between each question
          ],
        );
      }).toList(),
    );
  }
}
