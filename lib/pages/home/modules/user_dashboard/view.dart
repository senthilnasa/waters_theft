import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water/utils/api/data.dart';
import 'package:water/utils/api/uri.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  String? d0, d1, d2, d3, d4, d5, d6, d7;

  @override
  void initState() {
    loadData();
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 10), (Timer t) => loadData());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        makeDashboardItem("Hose Id", Icons.book, d0, Colors.orange),
        makeDashboardItem("Flow Rate", Icons.flood, d1, Colors.blue),
        makeDashboardItem(
            "Amount Water Consumed", Icons.water_drop, d2, Colors.red),
        makeDashboardItem(
            "Excess Water Consumed", Icons.bloodtype, d3, Colors.teal),
        makeDashboardItem(
            "Excess Water Fee", Icons.request_quote, d4, Colors.amber),
        makeDashboardItem("Water Fee", Icons.savings, d5, Colors.green),
        makeDashboardItem(
            "Total Fee", Icons.currency_rupee, d6, Colors.lightBlue),
        makeDashboardItem(
            "Water Quality", Icons.stacked_bar_chart, "Good", Colors.purple),
        makeDashboardItem("Updated At", Icons.timer, d7, Colors.purple),
      ],
    );
  }

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> loadData() async {
    var api = DataApiService(ApiConst.userDashboard);
    if (await api.gets()) {
      var d = api.data[0];
      setState(() {
        d0 = d['d0'].toString();
        d1 = d['d1'].toString();
        d2 = d['d2'].toString();
        d3 = d['d3'].toString();
        d4 = d['d4'].toString();
        d5 = d['d5'].toString();
        d6 = d['d6'].toString();
        d7 = DateTime.now().toString();
      });
    }
  }
}

Widget makeDashboardItem(String? title, IconData icon, String? data, Color c) {
  return Card(
    elevation: 8.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: c),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          "$title",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Text("$data",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}
