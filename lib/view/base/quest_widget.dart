import 'package:asthma_monitor/provider/SliderProvider.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class QuestWidget extends StatefulWidget {
  final String question;
  final String subquest;
  final double value;
  final ValueChanged<double> onChanged;
  const QuestWidget({
    Key key,
    @required this.onChanged,
    @required this.question,
    @required this.value,
    this.subquest,
  }) : super(key: key);

  @override
  _QuestWidgetState createState() => _QuestWidgetState();
}

class _QuestWidgetState extends State<QuestWidget> {
  double _defaultValue;

  @override
  void initState() {
    super.initState();
    _defaultValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final _questData = Provider.of<SliderProvider>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF92A3FD).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: poppinsRegular.copyWith(
              fontSize: 10.sp,
            ),
          ),
          if (widget.subquest != null)
            Text(
              widget.subquest,
              style: poppinsRegular.copyWith(
                fontSize: 8.sp,
                color: Colors.red,
              ),
            ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Slider(
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  value: widget.value,
                  autofocus: true,
                  label: widget.value.round().toString(),
                  onChanged: (widget.onChanged != null)
                      ? widget.onChanged
                      : (value) {
                          _questData.stateChangeValue = value;
                          _defaultValue = _questData.stateChangeValue;
                        },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sangat tidak setuju',
                      style: poppinsRegular.copyWith(
                        fontSize: 8.sp,
                      ),
                    ),
                    Text(
                      'Sangat setuju',
                      style: poppinsRegular.copyWith(
                        fontSize: 8.sp,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
