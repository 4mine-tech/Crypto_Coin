import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:crypto_coin/main.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.data, this.index, this.chartData})
      : super(key: key);

  final data;
  final index;
  final chartData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Image.network(
              data[index]['image'],
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              data[index]['name'],
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        leading: Container(
            margin: EdgeInsets.only(left: 16),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Text("Price Last 7 Days",
                style: TextStyle(
                    color: Color(0xFFEEEEEE),
                    fontWeight: FontWeight.w700,
                    fontSize: 25)),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: data[index]['price_change_percentage_24h'] > 0
                      ? Color(0xFF63D82D).withOpacity(0.1)
                      : Color(0xFFFF5A35).withOpacity(0.1)),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: AspectRatio(
                aspectRatio: 2 / 1.15,
                child: LineChart(LineChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: false,
                      ))),
                  backgroundColor: Colors.transparent,
                  gridData: FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (var i = 0;
                            i < data[index]['sparkline_in_7d']["price"].length;
                            i++)
                          FlSpot(i.toDouble(),
                              data[index]['sparkline_in_7d']["price"][i]),
                      ],
                      isCurved: true,
                      color: data[index]['price_change_percentage_24h'] > 0
                          ? Color(0xFF63D82D)
                          : Color(0xFFFF5A35),
                      barWidth: 1.5,
                      dotData: FlDotData(
                        show: false,
                      ),
                      // belowBarData: BarAreaData(
                      //     show: true, color: Colors.blue.withOpacity(0.2)),
                    )
                  ],
                )),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Currency Name",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text(data[index]['name'],
                        style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Current Price",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text("\$${data[index]['current_price'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Highest Price (24h)",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text("\$${data[index]['high_24h'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Lowest Price (24h)",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text("\$${data[index]['low_24h'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Price Changes (24h)",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text(
                        "\$${data[index]['price_change_24h'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color:
                                data[index]['price_change_percentage_24h'] > 0
                                    ? Color(0xFF63D82D)
                                    : Color(0xFFFF5A35),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Price Changes % (24h)",
                        style: TextStyle(
                            color: Color(0xFFEEEEEE).withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    Text(
                        "${data[index]['price_change_percentage_24h'].toStringAsFixed(2)}\%",
                        style: TextStyle(
                            color:
                                data[index]['price_change_percentage_24h'] > 0
                                    ? Color(0xFF63D82D)
                                    : Color(0xFFFF5A35),
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
