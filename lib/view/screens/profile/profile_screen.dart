import 'package:asthma_monitor/data/model/profile_model.dart';
import 'package:asthma_monitor/provider/profile_provider.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:asthma_monitor/utill/strings.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:asthma_monitor/di_container.dart' as di;

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences _sharedPreferences;

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _dateOfBirth;

  @override
  void initState() {
    super.initState();
    _sharedPreferences = di.sl();
    loadData();
  }

  void loadData() {
    Provider.of<ProfileProvider>(context, listen: false).getProfile();
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
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 3.h),
          child: SingleChildScrollView(
            child: Consumer<ProfileProvider>(
              builder: (context, state, child) {
                ProfileModel _profileModel = state.profileModel;
                if (state.isLoading) {
                  context.loaderOverlay.show();
                } else {
                  context.loaderOverlay.hide();
                  if (_profileModel != null) {
                    _fullnameController.text = _profileModel.fullname;
                    _emailController.text = _profileModel.email;
                    _dobController
                      ..text =
                          getFormattedDate(DateTime.parse(_profileModel.dob));
                    _dateOfBirth = DateFormat('yyyy-MM-dd', 'en_US')
                        .format(DateTime.parse(_profileModel.dob));
                    _genderController.text = _profileModel.gender;
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/user.png',
                          height: 8.h,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(width: 2.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _sharedPreferences.getString(AppConstants.NAME),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: poppinsMedium.copyWith(
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                _sharedPreferences
                                    .getString(AppConstants.EMAIL),
                                style: poppinsRegular.copyWith(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          CustomField(
                            hintText: 'Date of Birth',
                            controller: _dobController,
                            isShowPrefixIcon: true,
                            isIcon: true,
                            readOnly: true,
                            prefixIconUrl: 'assets/icon/calendar.png',
                            onTap: () async {
                              final DateTime picker = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate:
                                    DateTime(DateTime.now().year - 50, 12),
                                lastDate: DateTime(DateTime.now().year + 10),
                                locale: Locale('en'),
                              );
                              if (picker != null) {
                                _dobController.text = getFormattedDate(picker);
                                _dateOfBirth = DateFormat('yyyy-MM-dd', 'en_US')
                                    .format(picker);
                              }
                            },
                          ),
                          SizedBox(height: 3.h),
                          CustomField(
                            hintText: 'Gender',
                            controller: _genderController,
                            isShowSuffixIcon: true,
                            isIcon: true,
                            readOnly: true,
                            suffixIcon: Icons.arrow_drop_down_rounded,
                            onTap: () async {
                              final gender = await showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 2.5.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context, 'Male');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h),
                                            child: Text(
                                              'Male',
                                              style: poppinsRegular.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context, 'Female');
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h),
                                            child: Text(
                                              'Female',
                                              style: poppinsRegular.copyWith(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );

                              if (gender != null) {
                                _genderController.text = gender;
                              }
                            },
                          ),
                          SizedBox(height: 3.h),
                          CustomField(
                            hintText: 'Password',
                            isPassword: true,
                            isShowSuffixIcon: true,
                            controller: _passwordController,
                            isShowPrefixIcon: true,
                            prefixIconUrl: 'assets/icon/lock.png',
                            inputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 7.h),
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  label: 'Update',
                                  onTap: () async {
                                    Map<String, dynamic> data;

                                    if (_passwordController.text.isEmpty) {
                                      data = {
                                        "fullname": _fullnameController.text,
                                        "email": _emailController.text,
                                        "dob": _dateOfBirth,
                                        "gender": _genderController.text,
                                        "password": null
                                      };
                                    } else {
                                      data = {
                                        "fullname": _fullnameController.text,
                                        "email": _emailController.text,
                                        "dob": _dateOfBirth,
                                        "gender": _genderController.text,
                                        "password": _passwordController.text
                                      };
                                    }
                                    context.loaderOverlay.show();
                                    if (_formKey.currentState.validate()) {
                                      //
                                      print(data);
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .update(data: data)
                                          .then((value) {
                                        if (value.isSuccess) {
                                          context.loaderOverlay.hide();
                                          showCustomSnackBar(
                                              value.message, context,
                                              isError: false);
                                          Future.delayed(
                                                  Duration(milliseconds: 505))
                                              .then(
                                            (value) => loadData(),
                                          );
                                        } else {
                                          context.loaderOverlay.hide();
                                          showCustomSnackBar(
                                              value.message, context);
                                        }
                                      });
                                    } else {
                                      context.loaderOverlay.hide();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
