import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reetro_analyst_app/di.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyChartScreen extends StatefulWidget {
  const DailyChartScreen({super.key});

  @override
  State<DailyChartScreen> createState() => _DailyChartScreenState();
}

class _DailyChartScreenState extends State<DailyChartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<ChartData> getChart() {
    // di.chartApiService.getDailyStats(start: "2025-08-01", end: "2025-08-15");
    return List.generate(31,
        (index) => ChartData(index + 4, Random().nextDouble() * 10000000.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Chart"),
      ),
      body: Material(
        child: Container(
          height: MediaQuery.of(context).size.width * 0.5,
          child: SfCartesianChart(
            title: ChartTitle(text: 'Ví dụ Line Chart 2 đường'),
            legend: Legend(isVisible: true),
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
            series: <CartesianSeries>[
              LineSeries<ChartData, int>(
                name: 'Doanh thu',
                dataSource: getChart(),
                xValueMapper: (ChartData d, _) => d.x,
                yValueMapper: (ChartData d, _) => d.y,
                color: Colors.red,
              ),
              LineSeries<ChartData, int>(
                name: 'Chi phí',
                dataSource: getChart(),
                color: Colors.blue,
                xValueMapper: (ChartData d, _) => d.x,
                yValueMapper: (ChartData d, _) => d.y,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final int x;
  final double y;
  ChartData(this.x, this.y);
}
