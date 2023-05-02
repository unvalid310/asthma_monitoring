import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:asthma_monitor/provider/auth_provider.dart';
import 'package:asthma_monitor/provider/profile_provider.dart';
import 'package:asthma_monitor/utill/color_resources.dart';
import 'package:asthma_monitor/utill/routes.dart';
import 'package:asthma_monitor/utill/styles.dart';
import 'package:asthma_monitor/view/base/custom_field.dart';
import 'package:asthma_monitor/view/base/custom_snackbar.dart';
import 'package:asthma_monitor/view/base/primary_button.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                    'Welcome Back',
                    style: poppinsBold.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 7.h),
                  CustomField(
                    hintText: 'Email',
                    controller: _emailController,
                    isShowPrefixIcon: true,
                    prefixIconUrl: 'assets/icon/message.png',
                    inputType: TextInputType.emailAddress,
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
                          label: 'Login',
                          onTap: () {
                            context.loaderOverlay.show();
                            if (_formKey.currentState.validate()) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .login(
                                _emailController.text,
                                _passwordController.text,
                              )
                                  .then((isLogined) {
                                if (isLogined.isSuccess) {
                                  context.loaderOverlay.hide();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      Routes.DASHBOARD, (route) => false);
                                } else {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(
                                      'Login failed check your account.',
                                      context);
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
                      text: "Don't have account yet? ",
                      style: poppinsMedium.copyWith(
                        fontSize: 10.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: poppinsRegular.copyWith(
                            fontSize: 10.sp,
                            color: Color(0xFFEEA4CE),
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.pushNamed(
                                  context,
                                  Routes.REGISTER_SCREEN,
                                ),
                        ),
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
