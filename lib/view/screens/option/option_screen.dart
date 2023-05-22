import 'package:asthma_monitor/data/model/analize_model.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/option_button.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OptionScreen extends StatefulWidget {
  const OptionScreen({Key key}) : super(key: key);

  @override
  _OptionScreenState createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Provider.of<AnalyzeProvider>(context, listen: false).getAnalyze();
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
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 6.h),
          child: Consumer<AnalyzeProvider>(
            builder: (context, state, child) {
              AnalizeModel _analizeModel = state.analizeModel;
              print(state.isLoading);

              if (state.isLoading) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Which element\n would you like to test first?',
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                            fontSize: 18.sp,
                            color: ColorResources.COLOR_BLACK,
                          ),
                        ),
                        SizedBox(height: 7.h),
                        OptionButton(
                          success: (_analizeModel.body != 0.0) ? true : false,
                          label: 'Vital Sign',
                          icon: Icons.check_circle_outline_rounded,
                          onTap: () async {
                            var result = await Navigator.of(context)
                                .pushNamed(Routes.BODY_SCREEN);

                            if (result != null) {
                              if (result is bool) {
                                context.loaderOverlay.hide();
                                loadData();
                              }
                            }
                          },
                        ),
                        SizedBox(height: 2.h),
                        OptionButton(
                          success: (_analizeModel.envi != 0.0) ? true : false,
                          label: 'Air Quality',
                          icon: Icons.check_circle_outline_rounded,
                          onTap: () async {
                            var result = await Navigator.of(context)
                                .pushNamed(Routes.ENVIRONMENT_SCREEN);

                            if (result != null) {
                              if (result is bool) {
                                context.loaderOverlay.hide();
                                loadData();
                              }
                            }
                          },
                        ),
                        SizedBox(height: 2.h),
                        OptionButton(
                          success: (_analizeModel.mind != 0.0) ? true : false,
                          label: 'Psychological',
                          icon: Icons.check_circle_outline_rounded,
                          onTap: () async {
                            var result = await Navigator.of(context)
                                .pushNamed(Routes.MIND_SCREEN);

                            if (result != null) {
                              if (result is bool) {
                                context.loaderOverlay.hide();
                                loadData();
                              }
                            }
                          },
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                  if (_analizeModel.body != 0.0 &&
                      _analizeModel.envi != 0.0 &&
                      _analizeModel.mind != 0.0)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimaryButton(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.RESULT_SCREEN);
                            },
                            label: "See results",
                          ),
                        ],
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
