// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

// class WalletAndWithdrawScreen extends StatefulWidget {
//   @override
//   _WalletAndWithdrawScreenState createState() =>
//       _WalletAndWithdrawScreenState();
// }

// class _WalletAndWithdrawScreenState extends State<WalletAndWithdrawScreen> {
//   List<dynamic> _allData = [];
//   List<dynamic> _walletData = [];
//   List<dynamic> _withdrawData = [];
//   String? _selectedItem;

//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//   }

//   Future<String?> _getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<void> _fetchData() async {
//     String? token = await _getToken();
//     if (token == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Error: No token found. Please log in again.")),
//       );
//       return;
//     }

//     final walletData = await _fetchWalletData(token);
//     final withdrawData = await _fetchWithdrawData(token);

//     setState(() {
//       _walletData = walletData;
//       _withdrawData = withdrawData;
//       _allData = [
//         ...walletData.map((item) => {...item, 'type': 'Wallet'}),
//         ...withdrawData.map((item) => {...item, 'type': 'Withdraw'}),
//       ];
//       _selectedItem = 'All';
//     });
//   }

//   Future<List<dynamic>> _fetchWalletData(String token) async {
//     var headers = {
//       'Authorization': 'Bearer $token',
//     };
//     var response = await http.get(
//       Uri.parse('http://localhost:5000/v1/wallet/getWalletforUser'),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       var responseData = json.decode(response.body);
//       return responseData['data'];
//     } else {
//       print("Error fetching wallet data: ${response.reasonPhrase}");
//       return [];
//     }
//   }

//   Future<List<dynamic>> _fetchWithdrawData(String token) async {
//     var headers = {
//       'Authorization': 'Bearer $token',
//     };
//     var response = await http.get(
//       Uri.parse('http://localhost:5000/v1/withDrow/getWithdrowforUser'),
//       headers: headers,
//     );

//     if (response.statusCode == 200) {
//       var responseData = json.decode(response.body);
//       return responseData['data'];
//     } else {
//       print("Error fetching withdraw data: ${response.reasonPhrase}");
//       return [];
//     }
//   }

//   void _navigateToDetailScreen(dynamic data) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DetailScreen(data: data)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Wallet and Withdraw Data"),
//       ),
//       body: Column(
//         children: [
//           DropdownButton<String>(
//             value: _selectedItem,
//             hint: const Text("Select Data Type"),
//             onChanged: (value) {
//               setState(() {
//                 _selectedItem = value;
//               });
//             },
//             items: const [
//               DropdownMenuItem<String>(
//                 value: 'All',
//                 child: Text('All Data'),
//               ),
//               DropdownMenuItem<String>(
//                 value: 'Wallet',
//                 child: Text('Wallet Data'),
//               ),
//               DropdownMenuItem<String>(
//                 value: 'Withdraw',
//                 child: Text('Withdraw Data'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: _buildDataView(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDataView() {
//     List<dynamic> dataToShow;
//     switch (_selectedItem) {
//       case 'Wallet':
//         dataToShow = _walletData;
//         break;
//       case 'Withdraw':
//         dataToShow = _withdrawData;
//         break;
//       case 'All':
//       default:
//         dataToShow = _allData;
//         break;
//     }

//     if (dataToShow.isEmpty) {
//       return const Center(child: Text('No data available'));
//     }

//     return ListView.builder(
//       itemCount: dataToShow.length,
//       itemBuilder: (context, index) {
//         var item = dataToShow[index];
//         return ListTile(
//           hoverColor: Colors.green,
//           leading: Text('Amount: ${item['Amount']}'),
//           title: Text(
//               'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item['CreatedDate']))}'),
//           subtitle: Text('Type: ${item['type']}'),
//           onTap: () => _navigateToDetailScreen(item),
//           trailing: Builder(
//             builder: (context) {
//               if (item['type'] == 'Wallet') {
//                 return Text(item['state'] ?? 'N/A');
//               } else if (item['type'] == 'Withdraw') {
//                 return Text(item['IsCompleted'] ?? 'N/A');
//               } else {
//                 return Text('N/A');
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class DetailScreen extends StatelessWidget {
//   final dynamic data;

//   DetailScreen({required this.data, required wallet});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Detail Data"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Amount: ${data['Amount']}'),
//             Text(
//                 'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(data['CreatedDate']))}'),
//             Text('Merchant ID: ${data['merchantId'] ?? 'N/A'}'),
//             Text('Type: ${data['type']}'),
//             if (data['type'] == 'Wallet') ...[
//               Text(
//                   'Card Type: ${data['response']?['data']?['paymentInstrument']?['cardType'] ?? 'N/A'}'),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

