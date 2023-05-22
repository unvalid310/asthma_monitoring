import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BarChartGroupData makeGroupData(
    int x, double y1, double toY, Color leftBarColor) {
  return BarChartGroupData(
    barsSpace: 2.h,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: 20,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: toY,
          color: Color(0xFFE0E6FF).withOpacity(0.5),
        ),
      ),
    ],
  );
}
