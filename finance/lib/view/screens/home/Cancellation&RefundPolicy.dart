import 'package:flutter/material.dart';

class CancellationAndRefundPolicyScreen extends StatelessWidget {
  const CancellationAndRefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'Cancellation and Refund Policy',
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
                'Cancellation and Refund Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'This cancellation policy outlines about how you can cancel or seek a refund for a product / service that you have purchased through the Platform. Under this policy:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              buildBulletPoint(
                'Cancellations will only be considered if the request is made within 7 days of placing the order. However, cancellation requests may not be entertained if the orders have been communicated to such sellers/merchant(s) listed on the Platform and they have initiated the process of shipping them, or the product is out for delivery. In such an event, you may choose to reject the product at the doorstep.',
              ),
              buildBulletPoint(
                'Phonekart does not accept cancellation requests for perishable items like flowers, eatables, etc. However, the refund/replacement can be made if the user establishes that the quality of the product delivered is not good.',
              ),
              buildBulletPoint(
                'In case of receipt of damaged or defective items, please report to our customer service team. The request would be entertained once the seller/merchant listed on the Platform, has checked and determined the same at its own end. This should be reported within 7 days of receipt of products. In case you feel that the product received is not as shown on the site or as per your expectations, you must bring it to the notice of our customer service within 7 days of receiving the product. The customer service team, after looking into your complaint, will take an appropriate decision.',
              ),
              buildBulletPoint(
                'In case of complaints regarding the products that come with a warranty from the manufacturers, please refer the issue to them.',
              ),
              buildBulletPoint(
                'In case of any refunds approved by us, it will take 7 days for the refund to be processed to you.',
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
            style: const TextStyle(fontSize: 25, height: .7),
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
