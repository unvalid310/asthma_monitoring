// ignore_for_file: unused_local_variable, unused_field

import 'dart:math';

import 'package:asthma_monitor/data/model/result_model.dart';
import 'package:asthma_monitor/provider/result_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/view/screens/history/component/titles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:asthma_monitor/utill/strings.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/option_button.dart';
import 'package:asthma_monitor/view/screens/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'component/group_data.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  TextEditingController _bulanController = TextEditingController();
  DateTime _now = DateTime.now();

  final Color leftBarColor = const Color(0xff53fdd7);
  final Color centerBarColor = const Color(0xff0A7441);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;
  List<String> titles = [];
  List<double> _resultValue = [];
  List<BarChartGroupData> items = [];
  double _maxXy = 0;

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    loadData();
    _bulanController.text = getMonthFormated(_now);
  }

  void loadData() {
    Provider.of<ResultProvider>(context, listen: false).getHistory();
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
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 3.h),
          child: Column(
            children: [
              Text(
                'History',
                textAlign: TextAlign.center,
                style: poppinsRegular.copyWith(
                  fontSize: 12.sp,
                  color: ColorResources.COLOR_BLACK,
                ),
              ),
              SizedBox(height: 1.h),
              CustomField(
                hintText: 'Pilih Riwayat',
                controller: _bulanController,
                isShowPrefixIcon: true,
                isIcon: true,
                readOnly: true,
                prefixIconUrl: 'assets/icon/calendar.png',
                onTap: () async {
                  final selected = await showMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000, 8),
                    lastDate: DateTime(DateTime.now().year + 10),
                    locale: Locale('en'),
                  );

                  if (selected != null) {
                    _bulanController.text = getMonthFormated(selected);
                    Provider.of<ResultProvider>(context, listen: false)
                        .getHistory(
                      bulan: selected.month.toString(),
                      tahun: selected.year.toString(),
                    );
                    print('date ${selected.month} year ${selected.year}');
                  }
                },
              ),
              SizedBox(height: 5.h),
              Consumer<ResultProvider>(
                builder: (context, state, child) {
                  List<ResultModel> _historyList = state.historyList;

                  if (state.isLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

                  if (state.historyList.isNotEmpty) {
                    int i = 0;
                    _resultValue = [];
                    items = [];
                    titles = [];
                    rawBarGroups = [];
                    showingBarGroups = [];

                    for (var item in state.historyList) {
                      _resultValue.add(item.body);
                      _resultValue.add(item.envi);
                      _resultValue.add(item.mind);
                      titles.add(
                        getChartDate(DateTime.parse(item.date)),
                      );
                      items.add(
                        makeGroupData(
                          i,
                          item.body,
                          item.envi,
                          item.mind,
                        ),
                      );
                      i++;
                    }

                    _maxXy = _resultValue.reduce(max);
                    rawBarGroups = items;
                    showingBarGroups = rawBarGroups;
                  }

                  return (_historyList.isNotEmpty)
                      ? Container(
                          child: Column(
                            children: [
                              Container(
                                height: 30.h,
                                width: double.infinity,
                                child: BarChart(
                                  BarChartData(
                                    maxY: _maxXy,
                                    barTouchData: BarTouchData(
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBgColor: Colors.grey,
                                          getTooltipItem: (_a, _b, _c, _d) =>
                                              null,
                                        ),
                                        touchCallback:
                                            (FlTouchEvent event, response) {}),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: bottomTitles,
                                          reservedSize: 42,
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 28,
                                          interval: 1,
                                          getTitlesWidget: leftTitles,
                                        ),
                                      ),
                                    ),
                                    borderData: FlBorderData(show: false),
                                    barGroups: showingBarGroups,
                                    gridData: FlGridData(show: false),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.brightness_1_sharp,
                                      size: 15,
                                      color: leftBarColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Vital Sign',
                                      style: poppinsMedium.copyWith(
                                        fontSize: 8.sp,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.brightness_1_sharp,
                                      size: 15,
                                      color: rightBarColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Air Quality',
                                      style: poppinsMedium.copyWith(
                                        fontSize: 8.sp,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.brightness_1_sharp,
                                      size: 15,
                                      color: centerBarColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Psychological',
                                      style: poppinsMedium.copyWith(
                                        fontSize: 8.sp,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Center(
                            child: Text(
                              'Tidak ada data untuk ditampilkan',
                              textAlign: TextAlign.center,
                              style: poppinsRegular.copyWith(
                                fontSize: 12.sp,
                                color: ColorResources.COLOR_BLACK,
                              ),
                            ),
                          ),
                        );
                },
              ),
              Consumer<ResultProvider>(
                builder: (context, state, child) {
                  List<ResultModel> _historyList = state.historyList;

                  return (_historyList.isNotEmpty)
                      ? Expanded(
                          child: Container(
                            child: ListView.separated(
                              itemCount: _historyList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 2.h);
                              },
                              itemBuilder: (BuildContext context, int index) =>
                                  OptionButton(
                                label: getFormattedDate(
                                    DateTime.parse(_historyList[index].date)),
                                onTap: () {
                                  // Navigator.of(context)
                                  //     .pushNamed(Routes.RESULT_SCREEN);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                        date: _historyList[index].date,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icons.calendar_today_rounded,
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final style = poppinsMedium.copyWith(
      color: Color(0xff7589a2),
      fontSize: 10.sp,
    );

    String text;

    if (value == 0) {
      text = '0';
    } else if (value % 5 == 0) {
      text = value.toStringAsFixed(0);
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // List<String> titles = ["Mn", "Te", "Wd", "Tu", "Fr", "St", "Su"];

    Widget text = Text(
      titles[value.toInt()],
      style: poppinsMedium.copyWith(
        color: Color(0xff7589a2),
        fontSize: 10.sp,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y1,
    double y2,
    double y3,
  ) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: rightBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y3,
          color: centerBarColor,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
