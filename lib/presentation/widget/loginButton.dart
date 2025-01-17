import 'package:delayed_display/delayed_display.dart';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:cipherkey/utils/constants.dart' as constants;
import 'package:cipherkey/utils/dimensions.dart' as dimens;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/login_controller.getx.dart';

class LoginButton extends StatelessWidget {
  var formkey;
  LoginButton(this.formkey, {Key? key}) : super(key: key);
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
      child: Material(
          color: colors.AppColor.primaryColor,
          borderRadius: BorderRadius.circular(
              dimens.Dimens.submitButtonContainerBorderLogIn),
          shadowColor: colors.AppColor.shadowColor,
          elevation: dimens.Dimens.submitButtonElevationLogIn,
          child: InkWell(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  loginController.userDetectionFun(context);
                }
              },
              borderRadius: BorderRadius.circular(
                  dimens.Dimens.submitButtonContainerBorderLogIn),
              splashColor: colors.AppColor.splashColor,
              child: SizedBox(
                width: double.infinity,
                height: dimens.Dimens.submitButtonContainerHeightLogIn,
                child: Center(
                    child: Text(
                  constants.Constants.submitButtonTitleLogIn,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: colors.AppColor.secondaryColor),
                )),
              ))),
    );
  }
}
