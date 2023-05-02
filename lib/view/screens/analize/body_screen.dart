import 'package:asthma_monitor/data/model/body_analize_model.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key key}) : super(key: key);

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  final _formKey = GlobalKey<FormState>();
  int _id;
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _spo2Controller = TextEditingController();
  final TextEditingController _sleepingQualityController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    await Provider.of<AnalyzeProvider>(context, listen: false).getBodyAnalyze();
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
          width: double.infinity,
          child: SingleChildScrollView(
            child: Consumer<AnalyzeProvider>(
              builder: (context, state, child) {
                BodyAnalizeModel _bodyAnalizeModel = state.bodyAnalizeModel;
                if (state.isLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                  if (_bodyAnalizeModel != null) {
                    _id = int.parse(_bodyAnalizeModel.id);
                    _heartRateController.text = _bodyAnalizeModel.heartRate;
                    _spo2Controller.text = _bodyAnalizeModel.spo2;
                    _sleepingQualityController.text =
                        _bodyAnalizeModel.sleepingQuality;
                  }
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Fill your data',
                        style: poppinsBold.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 7.h),
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Heart Rate',
                                    style: poppinsMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: ColorResources.COLOR_BLACK,
                                    ),
                                  ),
                                  // Text(
                                  //   '60 - 100 bpm',
                                  //   style: poppinsMedium.copyWith(
                                  //     fontSize: 8.sp,
                                  //     color: Color(0xFFEEA4CE),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: CustomField(
                                hintText: 'Heart Rate',
                                controller: _heartRateController,
                                inputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "S",
                                      style: poppinsMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: ColorResources.COLOR_BLACK,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'p',
                                          style: poppinsRegular.copyWith(
                                            fontSize: 6.sp,
                                            color: ColorResources.COLOR_BLACK,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'O',
                                          style: poppinsRegular.copyWith(
                                            fontSize: 12.sp,
                                            color: ColorResources.COLOR_BLACK,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '2',
                                          style: poppinsRegular.copyWith(
                                            fontSize: 6.sp,
                                            color: ColorResources.COLOR_BLACK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   '95 - 100%',
                                  //   style: poppinsMedium.copyWith(
                                  //     fontSize: 8.sp,
                                  //     color: Color(0xFFEEA4CE),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: CustomField(
                                hintText: 'SpO2',
                                controller: _spo2Controller,
                                inputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sleeping quality',
                                    style: poppinsMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: ColorResources.COLOR_BLACK,
                                    ),
                                  ),
                                  // Text(
                                  //   '80 - 100%',
                                  //   style: poppinsMedium.copyWith(
                                  //     fontSize: 8.sp,
                                  //     color: Color(0xFFEEA4CE),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 7,
                              child: CustomField(
                                hintText: 'Sleeping quality',
                                controller: _sleepingQualityController,
                                inputType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              onTap: () {
                                context.loaderOverlay.show();
                                final data = {
                                  "heart_rate": _heartRateController.text,
                                  "spo2": _spo2Controller.text,
                                  "sleeping_quality":
                                      _sleepingQualityController.text
                                };

                                if (_formKey.currentState.validate()) {
                                  if (_id != null) {
                                    // updated
                                    Provider.of<AnalyzeProvider>(context,
                                            listen: false)
                                        .updateBodyAnalize(data: data, id: _id)
                                        .then(
                                      (value) {
                                        if (value.isSuccess) {
                                          Navigator.pop(context, true);
                                        } else {
                                          showCustomSnackBar(
                                              value.message, context);
                                        }
                                      },
                                    );
                                  } else {
                                    // created
                                    Provider.of<AnalyzeProvider>(context,
                                            listen: false)
                                        .postBodyAnalize(data: data)
                                        .then(
                                      (value) {
                                        if (value.isSuccess) {
                                          context.loaderOverlay.hide();
                                          Navigator.pop(context, true);
                                        } else {
                                          context.loaderOverlay.hide();
                                          showCustomSnackBar(
                                              value.message, context);
                                        }
                                      },
                                    );
                                  }
                                } else {
                                  context.loaderOverlay.hide();
                                }
                              },
                              label: 'Done',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
