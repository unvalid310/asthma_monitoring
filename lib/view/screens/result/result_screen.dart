import 'package:asthma_monitor/provider/analyze_provider.dart';
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
  int _body;
  int _envi;
  int _mind;
  int _max;
  double _indicator;

  @override
  void initState() {
    super.initState();
    _bodyData = [
      FlSpot(0, 1),
    ];
    _enviData = [
      FlSpot(0, 2),
    ];
    _mindData = [
      FlSpot(0, 3),
    ];
    loadData();
  }

  void loadData() {
    final _resultData = Provider.of<ResultProvider>(context, listen: false);
    _resultData.getResult(date: widget.date);

    if (_resultData.resultModel != null) {
      _body = _resultData.resultModel.body.round().toInt();
      _envi = _resultData.resultModel.envi.round().toInt();
      _mind = _resultData.resultModel.mind.round().toInt();
      _max = _resultData.resultModel.max.round().toInt();
      _indicator = _resultData.resultModel.max;

      _bodyData = [
        FlSpot(0, 1),
        FlSpot(_resultData.resultModel.body, 1),
      ];
      _enviData = [
        FlSpot(0, 2),
        FlSpot(_resultData.resultModel.envi, 2),
      ];
      _mindData = [
        FlSpot(0, 3),
        FlSpot(_resultData.resultModel.mind, 3),
      ];

      print('body >> ${_resultData.resultModel.body}');
    }
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
                          right: 16.0, left: 6.0, top: 25, bottom: 5),
                      child: LineChart(
                        sampleData2,
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

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: (_max != null) ? _max.toDouble() + 5 : 100,
        maxY: 4,
        minY: 0,
      );

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
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
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff75729e),
      fontSize: 10.sp,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'Body';
        break;
      case 2:
        text = 'Envi';
        break;
      case 3:
        text = 'Mind';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 50,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Color(0xff72719b),
      fontSize: 10.sp,
    );
    Widget text;
    if (value.toInt() == _body) {
      text = Text(value.round().toString(), style: style);
    } else if (value.toInt() == _envi) {
      text = Text(value.round().toString(), style: style);
    } else if (value.toInt() == _mind) {
      text = Text(value.round().toString(), style: style);
    } else {
      text = Text('');
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 50,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x444af699),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: _bodyData,
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x99aa4cfc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: _enviData,
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x4427b6fc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: _mindData,
      );
}
