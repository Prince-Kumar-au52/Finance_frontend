import 'dart:convert';
import 'package:finance/view/screens/auth/loginScreen.dart';
import 'package:finance/view/widgets/toaster.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    final String firstName = firstNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;

    final String serverUrl = 'https://finance-075c.onrender.com/v1/auth/register';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(serverUrl),
        headers: headers,
        body: json.encode({
          "FullName": firstName,
          "EmailId": email,
          "Password": password,
          "Role": "User"
        }),
      );
      
      String responseBody = await response.body;
      if (response.statusCode == 200 || response.statusCode == 201) {
        // showToast("Sign-up successful!", Colors.green);

          var responseData = json.decode(responseBody);
        String message = responseData['message'];
          showToast(message, Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        showToast(
          "Sign-up failed: ${response.body}",
          Colors.red,
        );
      }
    } catch (e) {
      showToast(
        "Error during sign-up: $e",
        Colors.red,
      );
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Widget buildTextFieldWithIcon({
    required TextEditingController controller,
    required String hintText,
    required bool isRequired,
  }) {
    return Container(
      height: 50,
      color: const Color.fromARGB(255, 240, 239, 239),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          suffixIcon: isRequired
              ? const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 8.0,
                )
              : null,
        ),
        validator: (value) {
          if (isRequired && (value == null || value.isEmpty)) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "SignUp",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(height: 60),
                      buildTextFieldWithIcon(
                        controller: firstNameController,
                        hintText: 'Full Name',
                        isRequired: true,
                      ),
                      const SizedBox(height: 20),
                      buildTextFieldWithIcon(
                        controller: emailController,
                        hintText: 'Email',
                        isRequired: true,
                      ),
                      const SizedBox(height: 20),
                      buildTextFieldWithIcon(
                        controller: passwordController,
                        hintText: 'Password',
                        isRequired: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 61, 124, 251),
                          ),
                          child: _loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 61, 124, 251),
                                  ),
                                )
                              : const Text(
                                  'Signup',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 61, 124, 251),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
