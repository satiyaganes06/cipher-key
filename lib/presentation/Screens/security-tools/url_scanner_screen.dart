import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:cipherkey/utils/dimensions.dart' as dimens;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/url_scanner_controller.getx.dart';
import '../../../core/networkService/virus_total_api_service.dart';

class UrlScannerScreen extends StatelessWidget {
  UrlScannerScreen({super.key});

  final controller = Get.put(UrlScannerController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildSearchBar(context),
          Obx(() => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: colors.AppColor.primaryColor,
                  ),
                )
              : const SizedBox())
        ],
      ),
    );
  }

  buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: DelayedDisplay(
        delay: Duration(milliseconds: dimens.Dimens.delayAnimationLogInPage),
        child: TextFormField(
          controller: controller.url,
          decoration: InputDecoration(
              hintText: "Search or scan a URL",
              suffixIcon: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.scanUrl();
                    }
                  },
                  child: Icon(
                    Icons.search,
                    color: colors.AppColor.accentColor,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.AppColor.accentColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      BorderSide(color: colors.AppColor.accentColor, width: 2)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter URL';
            } else if (value.isURL == false) {
              return 'Please enter valid URL';
            } else if (value.isURL == false) {
              return 'Please enter valid URL';
            }
            return null;
          },
        ),
      ),
    );
  }
}
