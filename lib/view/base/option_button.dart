import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OptionButton extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final IconData icon;
  final bool success;
  const OptionButton({
    Key key,
    @required this.label,
    @required this.onTap,
    @required this.icon,
    this.success = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
        decoration: BoxDecoration(
          border:
              Border.all(color: (success) ? Color(0xFF92A3FD) : Colors.grey),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: poppinsMedium.copyWith(
                  fontSize: 12.sp,
                  color: (success) ? Color(0xFF92A3FD) : Colors.grey,
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(
              icon,
              size: 18,
              color: (success) ? Color(0xFF92A3FD) : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
