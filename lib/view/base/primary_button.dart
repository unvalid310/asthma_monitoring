import 'package:flutter/material.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  const PrimaryButton({@required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9DCEFF),
                Color(0xFF92A3FD),
              ]),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          label,
          style: poppinsMedium.copyWith(
            fontSize: 13.sp,
            color: ColorResources.COLOR_WHITE,
          ),
        ),
      ),
    );
  }
}
