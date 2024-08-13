import 'dart:convert';
import 'package:finance/view/screens/addFund/addMoneyScreen.dart';
import 'package:finance/view/screens/wallet/walletDetailsScreen.dart';
import 'package:finance/view/screens/wallet/withdrawalDetailScreen.dart';
import 'package:finance/view/screens/withdrawelScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance/view/widgets/toaster.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int remainingMoney = 0;
  bool isLoading = true;
  bool isError = false;
  late Future<List<dynamic>> futureWalletData;
  late Future<List<dynamic>> futureWithdrawData;

  // Dropdown related variables
  String? selectedDropdownItem = 'wallet';
  List<String> dropdownItems = [
    'wallet',
    'withdraw',
  ];

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    fetchUserCount();
    futureWalletData = fetchWalletData();
    futureWithdrawData = fetchWithdrawData();
  }

  Future<void> fetchUserCount() async {
    final url =
        Uri.parse('https://finance-075c.onrender.com/v1/wallet/getMoney');
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
      return;
    }
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          remainingMoney = data['data']['remainingMoney'];
          isLoading = false;
        });
      } else {
        print(response.reasonPhrase);
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future<List<dynamic>> fetchWalletData() async {
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
      return [];
    }
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('http://localhost:5000/v1/wallet/getWalletforUser'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load wallet data');
    }
  }

  Future<List<dynamic>> fetchWithdrawData() async {
    String? token = await _getToken();
    if (token == null) {
      showToast("Error: No token found. Please log in again.", Colors.red);
      return [];
    }
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('http://localhost:5000/v1/withDrow/getWithdrowforUser'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load withdraw data');
    }
  }

  Future<void> _fetchData() async {
    if (selectedDropdownItem == 'wallet') {
      futureWalletData = fetchWalletData();
    } else if (selectedDropdownItem == 'withdraw') {
      futureWalletData = fetchWithdrawData();
    } else {
      futureWalletData = Future.value([]);
    }
    setState(() {});
  }

  Text _getTrailingText(Map<String, dynamic> item) {
    if (item['IsComleted'] == true && item['IsVerify'] == true) {
      return const Text(
        'Completed',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (item['IsRejected'] == true) {
      return const Text(
        'Rejected',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const Text(
        'Pending',
        style: TextStyle(
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 29, 65),
        title: const Text(
          'Wallet',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Set the drawer icon color to white
        ), // Add a title if needed
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: Container(
                height: 150,
                width: size.width * .9,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Balance",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 98, 98, 98),
                      ),
                    ),
                    Text(
                      "₹$remainingMoney",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddFund()),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: 60,
                      width: size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.arrow_circle_up,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Add fund",
                            // style: TextStyle(
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.bold,
                            //   color: Color.fromARGB(255, 98, 98, 98),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WithdrawScreen()),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: 60,
                      width: size.width * .4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.arrow_circle_down,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Withdrawal",
                            // style: TextStyle(
                            // fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            // color: Colors.black,
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Transaction history",
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 98, 98, 98),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedDropdownItem,
                  hint: const Text('Select an item'),
                  items: dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDropdownItem = newValue;
                      _fetchData(); // Fetch data based on the selected item
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureWalletData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 2)),
                            child: ListTile(
                              leading: selectedDropdownItem == 'wallet'
                                  ? Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_circle_up,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_circle_down,
                                        color: Colors.white,
                                      ),
                                    ),
                              title: Text(
                                selectedDropdownItem == 'wallet'
                                    ? 'Date: ${_formatDate(item['CreatedDate'])}'
                                    : 'Date: ${_formatDate(item['CreatedDate'])}',
                              ),
                              subtitle: Text(
                                selectedDropdownItem == 'wallet'
                                    ? 'Amount: ${item['Amount']}'
                                    : 'Amount: ${item['Amount']}',
                              ),
                              // trailing: selectedDropdownItem == 'withdraw'
                              //     ? Text(
                              //         item['IsComleted']
                              //             ? 'Completed'
                              //             : 'Failed',
                              //         style: TextStyle(
                              //           color: item['IsComleted']
                              //               ? Colors.green
                              //               : Colors.red,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       )
                              //     : null,
                              trailing: selectedDropdownItem == 'withdraw'
                                  ? _getTrailingText(item)
                                  : null,
                              onTap: () {
                                if (selectedDropdownItem == 'withdraw') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WithdrawalDetailScreen(
                                        item:
                                            item, // Pass the item data to the details screen
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        wallet: item,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    // Format date string to a readable format
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}
