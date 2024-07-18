import 'package:flutter/material.dart';



// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: FAQWidget(
//           faqList: [
//             {
//               "question": "What is the return policy?",
//               "answer":
//                   "Our return policy allows returns within 30 days of purchase."
//             },
//             {
//               "question": "How do I track my order?",
//               "answer":
//                   "You can track your order using the tracking number provided in the confirmation email."
//             },
//             {
//               "question": "Can I change my shipping address?",
//               "answer":
//                   "Yes, you can change your shipping address before the order is shipped."
//             },
//             {
//               "question": "What payment methods are accepted?",
//               "answer":
//                   "We accept credit/debit cards, PayPal, and bank transfers."
//             },
//           ],
//         ),
//       ),
//     );
//   }
// }

class FAQWidget extends StatelessWidget {
  final List<Map<String, String>> faqList;

  FAQWidget({required this.faqList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqList.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(faqList[index]["question"]!),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(faqList[index]["answer"]!),
            ),
          ],
        );
      },
    );
  }
}
