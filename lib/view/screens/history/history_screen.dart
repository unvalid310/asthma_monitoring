import 'package:asthma_monitor/data/model/result_model.dart';
import 'package:asthma_monitor/provider/result_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/strings.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/option_button.dart';
import 'package:asthma_monitor/view/screens/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
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
              Consumer<ResultProvider>(
                builder: (context, state, child) {
                  List<ResultModel> _historyList = state.historyList;
                  if (state.isLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

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
}
