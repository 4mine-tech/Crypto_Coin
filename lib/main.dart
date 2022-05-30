import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'components/detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final data = [];
  final chartData = [];

  Future getData() async {
    String url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true";
    var response = await http.get(Uri.parse(url));
    List responseBody = jsonDecode(response.body);
    setState(() {
      data.addAll(responseBody);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text("Crypto Coin",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF))),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("\$${data[index]['current_price'].toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFFFFFF))),
                    Text(
                        "${data[index]['price_change_percentage_24h'].toStringAsFixed(2)}%",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                data[index]['price_change_percentage_24h'] > 0
                                    ? Color(0xFF63D82D)
                                    : Color(0xFFFF5A35))),
                  ],
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: DecorationImage(
                          image: NetworkImage(data[index]['image']),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter)),
                ),
                title: Text(data[index]['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF))),
                subtitle: Text(data[index]['symbol'].toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF).withOpacity(0.6))),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(
                                index: index,
                                data: data,
                                chartData: chartData,
                              )));
                },
              );
            },
          ),
        ));
  }
}
