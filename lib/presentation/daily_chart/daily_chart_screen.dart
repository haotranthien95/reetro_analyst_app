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
    getThisAndLastMonthDateRange();
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

  _getThisMonthChart(String start, String end) {
    setState(() {
      loading = true;
    });
    di.get<ChartRepository>().getDailyStats(start, end).then((value) {
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

  _getLastMonthChart(String start, String end) {
    setState(() {
      loading = true;
    });
    di.get<ChartRepository>().getDailyStats(start, end).then((value) {
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
              title: const ChartTitle(text: 'Tổng quan doanh thu'),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                canShowMarker: true,
                activationMode: ActivationMode.singleTap,
                format: 'point.y',
                header: '',
                duration: 3000,
              ),
              onTooltipRender: (TooltipArgs args) {
                args.text = numberFormatter
                    .format(args.dataPoints?[(args.pointIndex ?? 0).toInt()].y);
              },
              primaryXAxis: const NumericAxis(
                minimum: 1,
                maximum: 31,
                interval: 1,
              ),
              primaryYAxis: const NumericAxis(),
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

  void getThisAndLastMonthDateRange() {
    final now = DateTime.now();
    final thisMonthFirst = DateTime(now.year, now.month, 1);
    final thisMonthLast = DateTime(now.year, now.month + 1, 0);
    final lastMonth = DateTime(now.year, now.month - 1, 1);
    final lastMonthFirst = DateTime(lastMonth.year, lastMonth.month, 1);
    final lastMonthLast = DateTime(lastMonth.year, lastMonth.month + 1, 0);

    String format(DateTime d) =>
        "${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    _getThisMonthChart(format(thisMonthFirst), format(thisMonthLast));
    _getLastMonthChart(format(lastMonthFirst), format(lastMonthLast));
  }
}

class ChartData {
  final int x;
  final double y;
  ChartData(this.x, this.y);
}
