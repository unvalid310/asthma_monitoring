import 'package:asthma_monitor/utill/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget leftTitles(double value, TitleMeta meta) {
  final style = poppinsMedium.copyWith(
    color: Color(0xFF7B6F72),
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
  );
  String text;
  if (value == 0) {
    text = '10';
  } else if (value == 50) {
    text = '50';
  } else if (value == 100) {
    text = '100';
  } else if (value == 200) {
    text = '200';
  } else if (value == 500) {
    text = '500';
  } else if (value == 1000) {
    text = '1000';
  } else {
    return Container();
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style),
  );
}
