import 'package:cipherkey/presentation/Screens/security-tools/password_generator_screen.dart';
import 'package:cipherkey/presentation/Screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:remixicon/remixicon.dart';
import '../../controller/login_controller.getx.dart';
import '../../core/localServices/device_info.dart';
import '../Screens/auth/local_auth/local_auth_screen.dart';
import '../Screens/chatbot/chatbot.dart';
import '../Screens/masterPasswordReq/master_password_hint_Screen.dart';

class CustomAppBar extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      leading: Container(color: colors.AppColor.primaryColor),
      // leading: GestureDetector(
      //   onTap:(){
      //     //navigatorController.handleMenuButtonPressed();
      //   },
      //   child: AvatarGlow(
      //     shape: BoxShape.circle,
      //     glowColor: colors.AppColor.tertiaryColor,
      //     endRadius: 25,
      //     child: OctoImage(
      //       image: const CachedNetworkImageProvider('https://thumbs.dreamstime.com/b/sg-logo-letter-monogram-slash-modern-designs-template-black-color-white-background-164908221.jpg'),
      //       errorBuilder: OctoError.icon(color: colors.AppColor.accentColor),
      //       fit: BoxFit.cover,
      //       imageBuilder: OctoImageTransformer.circleAvatar(),
      //       height: 30,
      //       progressIndicatorBuilder: (context, progress) {
      //         return const Loading();
      //       },
      //     )
      //   ),
      // ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Cipher',
              style: GoogleFonts.poppins(
                  color: colors.AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 18)),
          Text('Key',
              style: GoogleFonts.poppins(
                  color: colors.AppColor.secondaryColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.5,
                  fontSize: 18))
        ],
      ),
      // style: GoogleFonts.poppins(
      //     color: colors.AppColor.secondaryColor,
      //     fontWeight: FontWeight.bold,
      //     letterSpacing: 1),

      centerTitle: true,
      backgroundColor: colors.AppColor.primaryColor,
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Remix.chat_smile_2_fill),
          iconSize: 25,
          splashRadius: 20,
          color: colors.AppColor.secondaryColor,
          onPressed: () {
            Get.to(() => const ChatBotScreen());
          },
        )
      ],
    );
  }

  _showBottomSheet(BuildContext context) {
    return showModalActionSheet(
        context: context,
        title: 'Menu',
        builder: (context, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Get Master Password Hints',
                  style: GoogleFonts.poppins(
                      color: colors.AppColor.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => PasswordHintScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Iconsax.password_check,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Password Generator',
                  style: GoogleFonts.poppins(
                      color: colors.AppColor.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const PasswordGeneratorScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_rounded,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Settings',
                  style: GoogleFonts.poppins(
                      color: colors.AppColor.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const SettingScreen());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.lock,
                  color: colors.AppColor.tertiaryColor,
                ),
                title: Text(
                  'Lock now',
                  style: GoogleFonts.poppins(
                    color: colors.AppColor.tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  Get.offAll(() => LocalAuthScreen());
                },
              ),
            ],
          );
        });
  }
}
