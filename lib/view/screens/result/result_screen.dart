import 'dart:math';

import 'package:asthma_monitor/provider/result_provider.dart';
import 'package:asthma_monitor/utill/strings.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ResultScreen extends StatefulWidget {
  final String date;
  const ResultScreen({Key key, this.date}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<FlSpot> _bodyData;
  List<FlSpot> _enviData;
  List<FlSpot> _mindData;
  double _maxBody = 10;
  double _maxEnvi = 10;
  String _indicator;

  @override
  void initState() {
    super.initState();
    // _bodyData = [
    //   FlSpot(0, 1),
    // ];
    _enviData = [
      FlSpot(0, 1),
    ];
    loadData();
  }

  void loadData() {
    Provider.of<ResultProvider>(context, listen: false)
        .getResult(date: widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        body: Consumer<ResultProvider>(builder: (context, value, child) {
          if (value.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }

          if (value.bodyResult != null) {
            List<double> _tempBody = [
              double.parse(value.bodyResult.heartRate),
              double.parse(value.bodyResult.spo2),
              double.parse(value.bodyResult.sleepingQuality)
            ];

            _bodyData = [
              FlSpot(1, double.parse(value.bodyResult.heartRate)),
              FlSpot(2, double.parse(value.bodyResult.spo2)),
              FlSpot(3, double.parse(value.bodyResult.sleepingQuality)),
            ];

            _maxBody = _tempBody.reduce(max);
          }
          if (value.enviResult != null) {
            List<double> _tempEnvi = [
              double.parse(value.enviResult.temperature),
              double.parse(value.enviResult.humidity),
              double.parse(value.enviResult.co2),
              double.parse(value.enviResult.pm25),
            ];

            _enviData = [
              FlSpot(1, double.parse(value.enviResult.temperature)),
              FlSpot(2, double.parse(value.enviResult.humidity)),
              FlSpot(3, double.parse(value.enviResult.co2)),
              FlSpot(4, double.parse(value.enviResult.pm25)),
            ];

            _maxEnvi = _tempEnvi.reduce(max);
          }

          if (value.mindResult != null) {
            _mindData = [
              FlSpot(1, double.parse(value.mindResult.q1)),
              FlSpot(2, double.parse(value.mindResult.q2)),
              FlSpot(3, double.parse(value.mindResult.q3)),
              FlSpot(4, double.parse(value.mindResult.q4)),
              FlSpot(5, double.parse(value.mindResult.q5)),
              FlSpot(6, double.parse(value.mindResult.q6)),
              FlSpot(7, double.parse(value.mindResult.q7)),
              FlSpot(8, double.parse(value.mindResult.q8)),
              FlSpot(9, double.parse(value.mindResult.q9)),
              FlSpot(10, double.parse(value.mindResult.q10)),
            ];
          }

          return Container(
            padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 3.h),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Result Graphic',
                    textAlign: TextAlign.center,
                    style: poppinsBold.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    (widget.date != null)
                        ? getFormattedDate(DateTime.parse(widget.date))
                        : getFormattedDate(DateTime.now()),
                    style: poppinsRegular.copyWith(fontSize: 9.sp),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Vital Sign',
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 40.h,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2c274c),
                            Color(0xff46426c),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          right: 16.0, left: 8.0, top: 25),
                      child: LineChart(
                        bodyData,
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Air Quality',
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 40.h,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2c274c),
                            Color(0xff46426c),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          right: 16.0, left: 8.0, top: 25),
                      child: LineChart(
                        enviData,
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'Psychological',
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 40.h,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2c274c),
                            Color(0xff46426c),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          right: 16.0, left: 8.0, top: 25),
                      child: LineChart(
                        mindData,
                        swapAnimationDuration:
                            const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  if (_indicator != null)
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'your test result showing ',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "'$_indicator'",
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' as the highest indicator cousing your asthma to relapse',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.sp,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  LineChartData get bodyData => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: bodyTitleData,
        borderData: borderData,
        lineBarsData: [lineBarBody],
        minX: 0.5,
        maxX: 4,
        maxY: _maxBody != null ? _maxBody + 5 : 105,
        minY: 0,
      );

  LineChartData get enviData => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: enviTitleData,
        borderData: borderData,
        lineBarsData: [lineBarEnvi],
        minX: 0.5,
        maxX: 5,
        maxY: _maxEnvi != null ? _maxEnvi + 5 : 105,
        minY: 0,
      );

  LineChartData get mindData => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: mindTitleData,
        borderData: borderData,
        lineBarsData: [lineBarMind],
        minX: 0,
        maxX: 11,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData2 => LineTouchData(enabled: false);

  FlTitlesData get bodyTitleData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftBodyTitles(),
        ),
      );

  FlTitlesData get enviTitleData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: enviTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftEnviTitles(),
        ),
      );

  FlTitlesData get mindTitleData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: mindTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftMindTitles(),
        ),
      );

  Widget leftBodyTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff75729e),
      fontSize: 10.sp,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        text = '';
        break;
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget leftEnviTitleWidgets(double value, TitleMeta meta) {
    print('leftTitleWidgets $value');
    TextStyle style = TextStyle(
      color: Color(0xff75729e),
      fontSize: 10.sp,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10';
        break;
      case 20:
        text = '20';
        break;
      case 30:
        text = '30';
        break;
      case 40:
        text = '40';
        break;
      case 50:
        text = '50';
        break;
      case 60:
        text = '60';
        break;
      case 70:
        text = '70';
        break;
      case 80:
        text = '80';
        break;
      case 90:
        text = '90';
        break;
      case 100:
        text = '100';
        break;
      default:
        text = '';
        break;
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget leftMindTitleWidgets(double value, TitleMeta meta) {
    print('leftTitleWidgets $value');
    TextStyle style = TextStyle(
      color: Color(0xff75729e),
      fontSize: 9.sp,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = value.toInt().toString();
        break;
      case 2:
        text = value.toInt().toString();
        break;
      case 3:
        text = value.toInt().toString();
        break;
      case 4:
        text = value.toInt().toString();
        break;
      case 5:
        text = value.toInt().toString();
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    print('leftTitleWidgets $value');
    TextStyle style = TextStyle(
      color: Color(0xff75729e),
      fontSize: 9.sp,
    );
    String text;
    // switch (value.toInt()) {
    //   case 1:
    //     text = 'Vital Sign';
    //     break;
    //   case 2:
    //     text = 'Air Quality';
    //     break;
    //   case 3:
    //     text = 'Psychological';
    //     break;
    //   default:
    //     return Container();
    // }
    if (value.toInt() % 5 == 0) {
      text = value.toInt().toString();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftBodyTitles() => SideTitles(
        getTitlesWidget: leftBodyTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 85,
      );

  SideTitles leftEnviTitles() => SideTitles(
        getTitlesWidget: leftEnviTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 85,
      );

  SideTitles leftMindTitles() => SideTitles(
        getTitlesWidget: leftMindTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 20,
      );

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 85,
      );

  Widget bottomEnviTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff72719b),
      fontSize: 10.sp,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Temp.', style: style);
        break;
      case 2:
        text = Text('Hum.', style: style);
        break;
      case 3:
        text = Text('Co2', style: style);
        break;
      case 4:
        text = Text('Pm25', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: text,
    );
  }

  Widget bottomMindTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff72719b),
      fontSize: 9.sp,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('p1', style: style);
        break;
      case 2:
        text = Text('p2', style: style);
        break;
      case 3:
        text = Text('p3', style: style);
        break;
      case 4:
        text = Text('p4', style: style);
        break;
      case 5:
        text = Text('p5', style: style);
        break;
      case 6:
        text = Text('p6', style: style);
        break;
      case 7:
        text = Text('p7', style: style);
        break;
      case 8:
        text = Text('p8', style: style);
        break;
      case 9:
        text = Text('p9', style: style);
        break;
      case 10:
        text = Text('p10', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: text,
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff72719b),
      fontSize: 9.sp,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Heart Rate', style: style);
        break;
      case 2:
        text = Text('SpO2', style: style);
        break;
      case 3:
        text = Text('Sleeping Q.', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get enviTitles => SideTitles(
        showTitles: true,
        reservedSize: 55,
        interval: 1,
        getTitlesWidget: bottomEnviTitleWidgets,
      );

  SideTitles get mindTitles => SideTitles(
        showTitles: true,
        reservedSize: 55,
        interval: 1,
        getTitlesWidget: bottomMindTitleWidgets,
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 55,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineBarBody => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x444af699),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: _bodyData,
      );

  LineChartBarData get lineBarEnvi => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x99aa4cfc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: _enviData,
      );

  LineChartBarData get lineBarMind => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x4427b6fc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: _mindData,
      );
}
