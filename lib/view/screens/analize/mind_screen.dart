import 'package:asthma_monitor/data/model/mind_analize_model.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:asthma_monitor/view/base/quest_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MindScreen extends StatefulWidget {
  const MindScreen({Key key}) : super(key: key);

  @override
  State<MindScreen> createState() => _MindScreenState();
}

class _MindScreenState extends State<MindScreen> {
  int _id;

  double _q1 = 3;
  double _q2 = 3;
  double _q3 = 3;
  double _q4 = 3;
  double _q5 = 3;
  double _q6 = 3;
  double _q7 = 3;
  double _q8 = 3;
  double _q9 = 3;
  double _q10 = 3;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final _mindData = Provider.of<AnalyzeProvider>(context, listen: false);
    await _mindData.getMindAnalyze().then(
      (value) {
        if (_mindData.mindAnalizeModel != null) {
          _id = int.parse(_mindData.mindAnalizeModel.id);
          _q1 = double.parse(_mindData.mindAnalizeModel.q1);
          _q2 = double.parse(_mindData.mindAnalizeModel.q2);
          _q3 = double.parse(_mindData.mindAnalizeModel.q3);
          _q4 = double.parse(_mindData.mindAnalizeModel.q4);
          _q5 = double.parse(_mindData.mindAnalizeModel.q5);
          _q6 = double.parse(_mindData.mindAnalizeModel.q6);
          _q7 = double.parse(_mindData.mindAnalizeModel.q7);
          _q8 = double.parse(_mindData.mindAnalizeModel.q8);
          _q9 = double.parse(_mindData.mindAnalizeModel.q9);
          _q10 = double.parse(_mindData.mindAnalizeModel.q10);
        }
      },
    );
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
          padding: EdgeInsets.fromLTRB(2.h, 7.h, 2.h, 3.h),
          width: double.infinity,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Consumer<AnalyzeProvider>(
              builder: (context, state, child) {
                if (state.isLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                }

                return Column(
                  children: [
                    Text(
                      'Fill your data',
                      style: poppinsBold.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(height: 7.h),
                    QuestWidget(
                      question: 'Seberapa senang perasaan anda pada hari ini?',
                      value: _q1,
                      onChanged: (value) {
                        setState(() {
                          _q1 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question: 'Seberapa sedih perasaan anda pada hari ini?',
                      value: _q2,
                      onChanged: (double value) {
                        setState(() {
                          _q2 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question: 'Seberapa kesal perasaan anda hari ini?',
                      subquest: 'hal-hal yang membuat anda marah dan kesal.',
                      value: _q3,
                      onChanged: (double value) {
                        setState(() {
                          _q3 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question: 'Seberapa penat pikiran anda hari ini?',
                      value: _q4,
                      onChanged: (double value) {
                        setState(() {
                          _q4 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question: 'Seberapa berat aktivitas anda hari ini?',
                      value: _q5,
                      onChanged: (double value) {
                        setState(() {
                          _q5 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question: 'Seberapa melelahkan hari anda hari ini?',
                      value: _q6,
                      onChanged: (double value) {
                        setState(() {
                          _q6 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question:
                          'Apakah gejala asma anda muncul setelah anda melakukan aktivitas berat?',
                      value: _q7,
                      onChanged: (double value) {
                        setState(() {
                          _q7 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question:
                          'Apakah gejala asma anda menganggu aktivitas yang sedang anda lakukan saat ini? $_q8',
                      value: _q8,
                      onChanged: (double value) {
                        setState(() {
                          _q8 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question:
                          'Apakah gejala asma yang anda alami saat ini tergolong berat?',
                      value: _q9,
                      onChanged: (double value) {
                        setState(() {
                          _q9 = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                    QuestWidget(
                      question:
                          'Apakah gejala asma yang anda alami saat ini mengeluarkan suara seperti mengi?',
                      value: _q10,
                      onChanged: (double value) {
                        setState(() {
                          _q10 = value;
                        });
                      },
                    ),
                    SizedBox(height: 7.h),
                    PrimaryButton(
                      label: 'Done',
                      onTap: () {
                        context.loaderOverlay.show();
                        final data = {
                          "q1": _q1.round().toString(),
                          "q2": _q2.round().toString(),
                          "q3": _q3.round().toString(),
                          "q4": _q4.round().toString(),
                          "q5": _q5.round().toString(),
                          "q6": _q6.round().toString(),
                          "q7": _q7.round().toString(),
                          "q8": _q8.round().toString(),
                          "q9": _q9.round().toString(),
                          "q10": _q10.round().toString(),
                        };
                        print('data >> $data');

                        if (_id != null) {
                          // updated
                          Provider.of<AnalyzeProvider>(context, listen: false)
                              .updateMindAnalize(data: data, id: _id)
                              .then(
                            (value) {
                              if (value.isSuccess) {
                                Navigator.pop(context, true);
                              } else {
                                showCustomSnackBar(value.message, context);
                              }
                            },
                          );
                        } else {
                          // created
                          Provider.of<AnalyzeProvider>(context, listen: false)
                              .postMindAnalize(data: data)
                              .then(
                            (value) {
                              if (value.isSuccess) {
                                context.loaderOverlay.hide();
                                Navigator.pop(context, true);
                              } else {
                                context.loaderOverlay.hide();
                                showCustomSnackBar(value.message, context);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
