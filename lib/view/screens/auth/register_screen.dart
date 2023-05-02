import 'package:asthma_monitor/provider/auth_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/strings.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _dateOfBirth;

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
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 6.h),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Hey there,',
                    style: poppinsRegular.copyWith(
                      fontSize: 12.sp,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                  Text(
                    'Create an Account',
                    style: poppinsBold.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 7.h),
                  CustomField(
                    hintText: 'Fullname',
                    controller: _fullnameController,
                    isShowPrefixIcon: true,
                    prefixIconUrl: 'assets/icon/profile.png',
                  ),
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
                        firstDate: DateTime(DateTime.now().year - 50, 12),
                        lastDate: DateTime(DateTime.now().year + 10),
                        locale: Locale('en'),
                      );

                      if (picker != null) {
                        _dobController.text = getFormattedDate(picker);
                        _dateOfBirth =
                            DateFormat('yyyy-MM-dd', 'en_US').format(picker);
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
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
                    hintText: 'Email',
                    controller: _emailController,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.emailAddress,
                    prefixIconUrl: 'assets/icon/message.png',
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
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Sign Up',
                          onTap: () async {
                            final Map<String, dynamic> data = {
                              "fullname": _fullnameController.text,
                              "dob": _dateOfBirth,
                              "email": _emailController.text,
                              "gender": _genderController.text,
                              "password": _passwordController.text
                            };
                            context.loaderOverlay.show();
                            if (_formKey.currentState.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .registration(data)
                                  .then((value) {
                                if (value.isSuccess) {
                                  context.loaderOverlay.hide();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.LOGIN_SCREEN, (route) => false);
                                } else {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(value.message, context);
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
                  SizedBox(height: 2.h),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: poppinsMedium.copyWith(
                        fontSize: 10.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: poppinsRegular.copyWith(
                            fontSize: 10.sp,
                            color: Color(0xFFEEA4CE),
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, Routes.LOGIN_SCREEN),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
