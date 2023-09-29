import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Address Locator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AddressScreen(),
    );
  }
}

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Map<String, dynamic>> addresses = [
    {
      "pincode": 560041,
      "address": "Jayanagar",
    },
    {
      "pincode": 560069,
      "address": "JP Nagar",
    },
    {
      "pincode": 560083,
      "address": "Gottigere",
    },
    {
      "pincode": 560100,
      "address": "Electronic City",
    },
  ];

  String address = '';

  void getAddress(int pincode) {
    for (var entry in addresses) {
      if (entry['pincode'] == pincode) {
        setState(() {
          address = entry['address'];
        });
        return;
      }
    }
    setState(() {
      address = 'Invalid pincode';
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.headlineMedium!.copyWith(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Locator', style: style),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              style: style,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              decoration: InputDecoration(labelText: 'Enter Your Pincode'),
              onChanged: (value) {
                if (value.length == 6) {
                  int? pincode = int.tryParse(value);
                  if (pincode != null) {
                    getAddress(pincode);
                  } else {
                    setState(() {
                      address = 'Invalid pincode';
                    });
                  }
                } else {
                  setState(() {
                    address = '';
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Address: $address',
              style: TextStyle(
                fontSize: 30,
                fontFamily: "Poppins",
                color: address == 'Invalid pincode' ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
