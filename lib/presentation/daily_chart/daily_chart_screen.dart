import 'package:flutter/material.dart';
import 'package:reetro_analyst_app/di.dart';
import 'package:reetro_analyst_app/repositories/chart_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DailyChartScreen extends StatefulWidget {
  const DailyChartScreen({super.key});

  @override
  State<DailyChartScreen> createState() => _DailyChartScreenState();
}

class _DailyChartScreenState extends State<DailyChartScreen> {
  final numberFormatter = NumberFormat('#,###');
  @override
  void initState() {
    _getThisMonthChart();
    _getLastMonthChart();
    super.initState();
  }

  List<ChartData> chartSampleThisMonth =
      List.generate(31, (index) => ChartData(index + 1, 0.0));
  List<ChartData> chartSampleLastMonth =
      List.generate(31, (index) => ChartData(index + 1, 0.0));

  bool loading = true;

  List<ChartData> replaceValueChart(
      List<ChartData> current, List<ChartData> newValue) {
    for (var i = 0; i < current.length; i++) {
      final value = newValue.firstWhere(
        (element) => element.x == current[i].x,
        orElse: () => ChartData(current[i].x, 0.0),
      );
      current[i] = ChartData(current[i].x, value.y);
    }
    return current;
  }

  _getThisMonthChart() {
    setState(() {
      loading = true;
    });
    di
        .get<ChartRepository>()
        .getDailyStats("2025-09-01", "2025-09-30")
        .then((value) {
      value.fold((l) {
        setState(() {
          chartSampleThisMonth = l.map((e) {
            return ChartData(e.ngayTrongThang, e.tongGiaTri);
          }).toList();
          loading = false;
        });
      }, (r) {
        setState(() {
          loading = false;
        });
      });
    }).catchError((e) {
      setState(() {
        loading = false;
      });
    });
  }

  _getLastMonthChart() {
    setState(() {
      loading = true;
    });
    di
        .get<ChartRepository>()
        .getDailyStats("2025-08-01", "2025-08-31")
        .then((value) {
      value.fold((l) {
        setState(() {
          chartSampleLastMonth = l.map((e) {
            return ChartData(e.ngayTrongThang, e.tongGiaTri);
          }).toList();
          loading = false;
        });
      }, (r) {
        setState(() {
          loading = false;
        });
      });
    }).catchError((e) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Chart"),
      ),
      body: Material(
        child: Container(
          width: double.infinity,
          child: AspectRatio(
            aspectRatio: 20 / 7,
            child: SfCartesianChart(
              title: ChartTitle(text: 'Tổng quan doanh thu'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                canShowMarker: true,
                activationMode: ActivationMode.singleTap, // tap để hiện
                format:
                    'point.y', // hoặc '{series.name}\nX: point.x\nY: point.y'
                header: '', // bỏ header mặc định
                duration: 3000, // ms
              ),
              onTooltipRender: (TooltipArgs args) {
                args.text =
                    '${numberFormatter.format(args.dataPoints?[(args.pointIndex ?? 0).toInt()].y)}';
              },
              primaryXAxis: NumericAxis(
                minimum: 1,
                maximum: 31,
                interval: 1,
              ),
              primaryYAxis: NumericAxis(),
              series: <CartesianSeries>[
                LineSeries<ChartData, int>(
                  name: 'Doanh thu tháng này',
                  dataSource: chartSampleThisMonth,
                  xValueMapper: (ChartData d, _) => d.x,
                  yValueMapper: (ChartData d, _) => d.y,
                  width: 2,
                  color: Colors.red,
                ),
                LineSeries<ChartData, int>(
                  name: 'Doanh thu tháng trước',
                  dataSource: chartSampleLastMonth,
                  color: Colors.blue,
                  width: 2,
                  xValueMapper: (ChartData d, _) => d.x,
                  yValueMapper: (ChartData d, _) => d.y,
                ),
              ],
            ),
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
