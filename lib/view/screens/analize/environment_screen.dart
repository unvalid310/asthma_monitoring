import 'package:asthma_monitor/data/model/envi_analize_model.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loader_overlay/src/overlay_controller_widget_extension.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EnvironmentScreen extends StatefulWidget {
  EnvironmentScreen({Key key}) : super(key: key);

  @override
  State<EnvironmentScreen> createState() => _EnvironmentScreenState();
}

class _EnvironmentScreenState extends State<EnvironmentScreen> {
  final _formKey = GlobalKey<FormState>();
  int _id;
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _humidityController = TextEditingController();
  final TextEditingController _co2Controller = TextEditingController();
  final TextEditingController _pm25Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() async {
    await Provider.of<AnalyzeProvider>(context, listen: false).getEnviAnalyze();
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
                EnviAnalizeModel _enviAnalizeModel = state.enviAnalizeModel;
                if (state.isLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                  if (_enviAnalizeModel != null) {
                    _id = int.parse(_enviAnalizeModel.id);
                    _temperatureController.text = _enviAnalizeModel.temperature;
                    _humidityController.text = _enviAnalizeModel.humidity;
                    _co2Controller.text = _enviAnalizeModel.co2;
                    _pm25Controller.text = _enviAnalizeModel.pm25;
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
                                    'Temperature',
                                    style: poppinsMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: ColorResources.COLOR_BLACK,
                                    ),
                                  ),
                                  // Text(
                                  //   '15 - 12 C',
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
                                hintText: 'Temperature',
                                controller: _temperatureController,
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
                                    'Humidity',
                                    style: poppinsMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: ColorResources.COLOR_BLACK,
                                    ),
                                  ),
                                  // Text(
                                  //   '40 - 60%',
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
                                hintText: 'Humidity',
                                controller: _humidityController,
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
                                      text: "C",
                                      style: poppinsMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: ColorResources.COLOR_BLACK,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'o',
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
                                  //   '< 100 ppm',
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
                                hintText: 'Co2',
                                controller: _co2Controller,
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
                                      text: "PM",
                                      style: poppinsMedium.copyWith(
                                        fontSize: 12.sp,
                                        color: ColorResources.COLOR_BLACK,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '2.5',
                                          style: poppinsRegular.copyWith(
                                            fontSize: 6.sp,
                                            color: ColorResources.COLOR_BLACK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   '< 100 ppm',
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
                                hintText: 'PM2.5',
                                controller: _pm25Controller,
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
                                  "temperature": _temperatureController.text,
                                  "humidity": _humidityController.text,
                                  "co2": _co2Controller.text,
                                  "pm25": _pm25Controller.text,
                                };

                                if (_formKey.currentState.validate()) {
                                  if (_id != null) {
                                    // updated
                                    Provider.of<AnalyzeProvider>(context,
                                            listen: false)
                                        .updateEnviAnalize(data: data, id: _id)
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
                                        .postEnviAnalize(data: data)
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
