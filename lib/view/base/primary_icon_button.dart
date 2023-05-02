import 'package:flutter/material.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:sizer/sizer.dart';

class PrimaryIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;
  const PrimaryIconButton({@required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.5.h),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF9DCEFF),
              Color(0xFF92A3FD),
            ],
          ),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: ColorResources.COLOR_WHITE,
        ),
      ),
      onTap: onTap,
    );
  }
}
