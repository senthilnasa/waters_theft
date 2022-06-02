import 'package:flutter/material.dart';
import 'package:high_chart/high_chart.dart';
import 'package:water/utils/api/uri.dart';

import '../../../../utils/api/data.dart';

class UserUsageLog extends StatefulWidget {
  UserUsageLog({Key? key}) : super(key: key);

  @override
  State<UserUsageLog> createState() => _UserUsageLogState();
}

class _UserUsageLogState extends State<UserUsageLog> {
  var data1 = ''' {
    chart: {
        type: 'column'
    },
    title: {
        text: 'Monthly Average Water Usage'
    },
    
    xAxis: {
        categories: [
            
            'Mar',
            'Apr',
            'May',
            
        ],
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Water Usage (ml)'
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f} ml</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [{
        name: 'Water Usage',
        data: [0, 0, 0]

    }]
    }''';
  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HighCharts(
      loader: const SizedBox(
        width: 200,
        child: LinearProgressIndicator(),
      ),
      size: const Size(400, 400),
      data: data1,
      scripts: const [
        "https://code.highcharts.com/highcharts.js",
        'https://code.highcharts.com/modules/networkgraph.js',
        'https://code.highcharts.com/modules/exporting.js',
      ],
    );
  }

  Future<void> load() async {
    var api = DataApiService(ApiConst.usageLog);
    if (await api.gets()) {
      data1 = '''{
    chart: {
        type: 'column'
    },
    title: {
        text: 'Monthly Average Water Usage'
    },
    
    xAxis: {
        categories: [
            
            'Mar',
            'Apr',
            'May',
            
        ],
        crosshair: true
    },
    yAxis: {
        min: 0,
        title: {
            text: 'Water Usage (ml)'
        }
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
            '<td style="padding:0"><b>{point.y:.1f} ml</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
        column: {
            pointPadding: 0.2,
            borderWidth: 0
        }
    },
    series: [{
        name: 'Water Usage',
        data: [704, 1407, ${api.data[0]['d1']}]

    }]
    }''';
      setState(() {});
    }
  }
}
