import 'package:asthma_monitor/data/model/analize_model.dart';
import 'package:asthma_monitor/provider/analyze_provider.dart';
import 'package:asthma_monitor/provider/auth_provider.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:asthma_monitor/di_container.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences _sPref = di.sl();

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
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi,',
                      style: poppinsRegular.copyWith(
                        fontSize: 12.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            (_sPref.getString(AppConstants.NAME) != '')
                                ? _sPref.getString(AppConstants.NAME)
                                : '-',
                            style: poppinsRegular.copyWith(
                              fontSize: 12.sp,
                              color: ColorResources.COLOR_BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.account_circle_outlined,
                          size: 25,
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          highlightColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.logout_outlined,
                              size: 15,
                            ),
                          ),
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .logout()
                                .then(
                              (value) {
                                if (value) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.LOGIN_SCREEN, (route) => false);
                                } else {
                                  showCustomSnackBar(
                                      'Terjadi kesalahan', context);
                                }
                              },
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              Consumer<AnalyzeProvider>(
                builder: (context, state, child) {
                  AnalizeModel _analizeModel = state.analizeModel;

                  if (state.isLoading) {
                    context.loaderOverlay.show();
                  } else {
                    context.loaderOverlay.hide();
                  }

                  return (state.analizeModel != null)
                      ? Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrimaryButton(
                                onTap: () async {
                                  Navigator.of(context)
                                      .pushNamed(Routes.OPTION_SCREEN)
                                      .then(
                                        (value) => loadData(),
                                      );
                                },
                                label: "Let's start analyze",
                              ),
                            ],
                          ),
                        )
                      : SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
