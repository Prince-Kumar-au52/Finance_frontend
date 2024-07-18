import 'dart:html';
import 'dart:js_util';
import 'package:finance/view/screens/addFund/addMoneyScreen.dart';
import 'package:finance/view/screens/addFund/checkk.dart';
import 'package:flutter/material.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  void openCheckout() {
    var options = RazorpayOptions(
      key: 'rzp_test_1DP5mmOlF5G5ag',
      // amount: (double.parse(userAmount) * 100).toInt().toString(),
      amount:1000.toString(),
      name: 'Prince Kumar',
      description: 'Fine T-Shirt',
      prefill: Prefill(contact: '8888888888', email: 'test@razorpay.com'),
      external: External(wallets: ['paytm']),
    );

    var razorpay = Razorpay(options);

    razorpay.on('payment.success', allowInterop((response) {
      String paymentId = response["razorpay_payment_id"];
      window.alert('SUCCESS: Payment ID - $paymentId');
      print('Payment Success: $response');
    }));

    razorpay.on('payment.error', allowInterop((response) {
      String errorCode = response["error"]["code"];
      String errorDescription = response["error"]["description"];
      window.alert('ERROR: $errorCode - $errorDescription');
      print('Payment Error: $response');
    }));

    razorpay.on('payment.external_wallet', allowInterop((response) {
      String externalWallet = response["external_wallet"];
      window.alert('EXTERNAL WALLET: $externalWallet');
      print('External Wallet: $response');
    }));

    razorpay.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay Sample App'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: openCheckout, child: const Text('Pay')),
          ],
        ),
      ),
    );
  }
}
