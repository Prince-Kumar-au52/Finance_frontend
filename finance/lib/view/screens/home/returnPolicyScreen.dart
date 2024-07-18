import 'package:flutter/material.dart';

class ReturnsPolicyScreen extends StatelessWidget {
  const ReturnsPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'Returns Policy',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Returns Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'We offer refund/exchange within the first 7 days from the date of your purchase. If 7 days have passed since your purchase, you will not be offered return, exchange, or refund of any kind. To be eligible for a return or exchange:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              buildBulletPoint(
                'The purchased item should be unused and in the same condition as you received it.',
              ),
              buildBulletPoint(
                'The item must have original packaging.',
              ),
              buildBulletPoint(
                'If the item that you purchased was on sale, then the item may not be eligible for a return/exchange.',
              ),
              const SizedBox(height: 10),
              const Text(
                'Further, only such items are replaced by us (based on an exchange request) if such items are found defective or damaged.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'If you need to place a return/exchange request for an eligible product/item (as applicable), you need to send us an email at phonekart.help@gmail.com.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'You agree that there may be a certain category of products/items that are exempted from returns or refunds. Such categories of the products would be identified to you at the time of purchase.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'For exchange/return accepted request(s) (as applicable), once your returned product/item is received and inspected by us, we will send you an email to notify you about receipt of the returned/exchanged product. Further, if the same has been approved after the quality check at our end, your request (i.e. return/exchange) will be processed in accordance with our policies.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
