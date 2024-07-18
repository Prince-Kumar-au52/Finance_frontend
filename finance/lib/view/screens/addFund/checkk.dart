@JS()
library razorpay_web;

import 'package:js/js.dart';

@JS('Razorpay')
class Razorpay {
  external Razorpay(RazorpayOptions options);
  external void open();
  external void on(String event, Function callback);
  external void close();
}

@JS()
@anonymous
class RazorpayOptions {
  external factory RazorpayOptions({
    required String key,
    required String amount,
    required String name,
    required String description,
    required Prefill prefill,
    required External external,
  });

  external String get key;
  external String get amount;
  external String get name;
  external String get description;
  external Prefill get prefill;
  external External get external;
}

@JS()
@anonymous
class Prefill {
  external factory Prefill({required String contact, required String email});

  external String get contact;
  external String get email;
}

@JS()
@anonymous
class External {
  external factory External({required List<String> wallets});

  external List<String> get wallets;
}
