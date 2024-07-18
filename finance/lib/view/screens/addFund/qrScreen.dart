// import 'dart:developer';
// import 'package:finance/view/screens/addFund/addMoneyScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class QrScreen extends StatefulWidget {
//   const QrScreen({Key? key}) : super(key: key);

//   @override
//   State<QrScreen> createState() => _QrScreenState();
// }

// class _QrScreenState extends State<QrScreen> {
//   late Razorpay _razorpay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Razorpay Sample App'),
//       ),
//       body: Center(
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//             ElevatedButton(onPressed: openCheckout, child: const Text('Open'))
//           ])),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_1DP5mmOlF5G5ag',
//       'amount': 1000,
//       // 'amount': double.parse(userAmount),
//       'name': 'Prince kumar.',
//       'description': 'Fine T-Shirt',
//       'send_sms_hash': true,
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     log('Success Response: $response');
//     Fluttertoast.showToast(
//         msg: "SUCCESS: ${response.paymentId!}",
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     log('Error Response: $response');
//     Fluttertoast.showToast(
//         msg: "ERROR: ${response.code} - ${response.message!}",
//         toastLength: Toast.LENGTH_SHORT);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     log('External SDK Response: $response');
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: ${response.walletName!}",
//         toastLength: Toast.LENGTH_SHORT);
//   }
// }
