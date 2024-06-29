import 'dart:math';

import 'package:cipherkey/model/virus_total_model.dart';
import 'package:cipherkey/presentation/Widget/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/networkService/virus_total_api_service.dart';
import '../presentation/Screens/security-tools/view_url_report_screen.dart';

class UrlScannerController extends GetxController {
  TextEditingController url = TextEditingController();
  var isLoading = false.obs;
  String? dataID;
  VirusTotalModel? dataURLReport;
  var filteredResult;

  var orderedValues = [
    'malicious',
    'phishing',
    'suspicious',
    'clean',
    'unrated'
  ];

  void scanUrl() async {
    isLoading.value = true;

    try {
      dataID = await VirusTotalApiService().scanUrl(url.text);

      Map<String, dynamic> response =
          await VirusTotalApiService().getReport(dataID!.split('-')[1]);

      if (response['status']) {
        dataURLReport = response['data'];
        // var result =
        //     dataURLReport!.data!.attributes!.lastAnalysisResults.values.toList();

        // filteredResult =
        //     orderedValues.where((value) => result.contains(value)).toList();
        isLoading.value = false;

        // print(dataURLReport!.data!.attributes!.lastAnalysisDate.toString());
        Get.to(() => const ViewUrlReportScreen());
      } else {
        isLoading.value = false;
        failMessage(Get.context!, response['data'].toString());
      }
    } catch (e) {
      print("Error: " + e.toString());
      isLoading.value = false;
      failMessage(Get.context!, 'Not found or something went wrong');
    }
  }

  void castVote({required bool isHarmless}) async {
    try {
      await VirusTotalApiService()
          .castVoteForURL(dataID!.split('-')[1], isHarmless);
      successMessage(Get.context!, "Vote casted successfully");
    } catch (e) {
      failMessage(Get.context!, e.toString());
    }
  }

  void rescanURL() async {
    try {
      String response =
          await VirusTotalApiService().reScanUrl(dataID!.split('-')[1]);
      successMessage(Get.context!, response);
    } catch (e) {
      debugPrint(e.toString());
      failMessage(Get.context!, 'Something went wrong');
    }
  }

  formatDate(int unixTimestamp) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000, isUtc: true);
    String formattedDateTime =
        dateTime.toIso8601String().replaceFirst('T', ' ').substring(0, 19) +
            ' UTC';

    return formattedDateTime;
  }
}
