import 'package:cipherkey/presentation/widget/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:cipherkey/utils/dimensions.dart' as dimens;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:remixicon/remixicon.dart';
import '../../../controller/url_scanner_controller.getx.dart';
import '../../../model/virus_total_model.dart';
import '../../widget/appbar.dart';
import '../../widget/custom_appbar.dart';

enum UrlScannerState { phishing, malicious, clean, unrated, suspicious }

class ViewUrlReportScreen extends StatefulWidget {
  const ViewUrlReportScreen({super.key});

  @override
  State<ViewUrlReportScreen> createState() => _ViewUrlReportScreenState();
}

class _ViewUrlReportScreenState extends State<ViewUrlReportScreen> {
  final controller = Get.find<UrlScannerController>();
  List<String> resultKeys = [];

  bool voteCastHarmless = false;
  bool voteCastMalicious = false;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    resultKeys = controller
        .dataURLReport!.data!.attributes!.lastAnalysisResults.keys
        .toList();
    return Scaffold(
        appBar: CommonAppbar(
          title: 'URL Report',
          isBackBtnEnable: true,
          isActionBtnEnable: true,
          icon: const Icon(Remix.scan_line),
          actionBtnFunction: () {
            controller.rescanURL();
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Space(40)),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: buildScoreDiagram()),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              controller.castVote(isHarmless: false);
                              setState(() {
                                voteCastMalicious = true;
                                voteCastHarmless = false;
                              });
                            },
                            splashRadius: 20,
                            tooltip: 'This URL is not safe to visit',
                            icon: Icon(
                              Icons.close_outlined,
                              color: voteCastMalicious != true
                                  ? colors.AppColor.subtitle2Color
                                  : colors.AppColor.fail2,
                              size: 25,
                            )),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text(
                            'Community Trust Score',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: colors.AppColor.subtitle2Color,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.castVote(isHarmless: true);
                              setState(() {
                                voteCastHarmless = true;
                                voteCastMalicious = false;
                              });
                            },
                            splashRadius: 20,
                            tooltip: 'This URL is safe to visit',
                            icon: Icon(
                              Icons.check_outlined,
                              color: voteCastHarmless != true
                                  ? colors.AppColor.subtitle2Color
                                  : colors.AppColor.success,
                              size: 25,
                            )),
                      ])),
            ),
            SliverToBoxAdapter(child: Space(20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    title: Text('URL',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        controller.dataURLReport!.data!.attributes!.lastFinalUrl
                            .toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width,
                            child: Text('History',
                                style: GoogleFonts.poppins(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                          Space(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('First Submission',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  controller
                                      .formatDate(controller
                                              .dataURLReport!
                                              .data!
                                              .attributes!
                                              .firstSubmissionDate ??
                                          0)
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Last Submission',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  controller
                                      .formatDate(controller
                                              .dataURLReport!
                                              .data!
                                              .attributes!
                                              .lastSubmissionDate ??
                                          0)
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Last Analysis',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  controller
                                      .formatDate(controller
                                              .dataURLReport!
                                              .data!
                                              .attributes!
                                              .lastAnalysisDate ??
                                          0)
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: Space(20)),
            SliverToBoxAdapter(
              child: ListTile(
                  title: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Security Vendor\'s',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ]),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Status',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ])),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: resultKeys.length,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  var data = controller.dataURLReport!.data!.attributes!
                      .lastAnalysisResults[resultKeys[index]]!;
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(data.engineName!,
                          style: GoogleFonts.poppins(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                    ),
                    trailing: Builder(builder: (context) {
                      if (data.result == 'clean') {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: colors.AppColor.success,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(data.result!,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.lightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        );
                      } else if (data.result == 'malicious') {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(data.result!,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.lightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        );
                      } else if (data.result == 'phishing') {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: colors.AppColor.fail,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(data.result!,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.lightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        );
                      } else if (data.result == 'suspicious') {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: colors.AppColor.premiumColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(data.result!,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.lightGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(data.result!,
                              style: GoogleFonts.poppins(
                                  color: colors.AppColor.tertiaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        );
                      }
                    }),
                  );
                },
              ),
            ),
          ],
        ));

    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       ListTile(
    //           title: Row(mainAxisSize: MainAxisSize.min, children: [
    //             Container(
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(20)),
    //               child: Text('Security Vendor\'s',
    //                   style: GoogleFonts.poppins(
    //                       fontSize: 12, fontWeight: FontWeight.bold)),
    //             ),
    //           ]),
    //           trailing: Row(mainAxisSize: MainAxisSize.min, children: [
    //             Container(
    //               padding: const EdgeInsets.all(10),
    //               decoration: BoxDecoration(
    //                   color: Colors.grey[200],
    //                   borderRadius: BorderRadius.circular(20)),
    //               child: Text('Status',
    //                   style: GoogleFonts.poppins(
    //                       fontSize: 12, fontWeight: FontWeight.bold)),
    //             ),
    //           ])),
    //       ListView.separated(
    //         shrinkWrap: true,
    //         itemCount: resultKeys.length,
    //         separatorBuilder: (context, index) => const Divider(),
    //         itemBuilder: (context, index) {
    //           var data = controller.dataURLReport!.data!.attributes!
    //               .lastAnalysisResults[resultKeys[index]]!;
    //           return ListTile(
    //             title: Padding(
    //               padding: const EdgeInsets.only(left: 10),
    //               child: Text(data.engineName!,
    //                   style: GoogleFonts.poppins(
    //                       fontSize: 12, fontWeight: FontWeight.w500)),
    //             ),
    //             trailing: Builder(builder: (context) {
    //               if (data.result == 'clean') {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                       color: colors.AppColor.success,
    //                       borderRadius: BorderRadius.circular(20)),
    //                   child: Text(data.result!,
    //                       style: GoogleFonts.poppins(
    //                           color: colors.AppColor.lightGrey,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w500)),
    //                 );
    //               } else if (data.result == 'malicious') {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                       color: Colors.red,
    //                       borderRadius: BorderRadius.circular(20)),
    //                   child: Text(data.result!,
    //                       style: GoogleFonts.poppins(
    //                           color: colors.AppColor.lightGrey,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w500)),
    //                 );
    //               } else if (data.result == 'phishing') {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                       color: colors.AppColor.fail,
    //                       borderRadius: BorderRadius.circular(20)),
    //                   child: Text(data.result!,
    //                       style: GoogleFonts.poppins(
    //                           color: colors.AppColor.lightGrey,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w500)),
    //                 );
    //               } else if (data.result == 'suspicious') {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                       color: colors.AppColor.premiumColor,
    //                       borderRadius: BorderRadius.circular(20)),
    //                   child: Text(data.result!,
    //                       style: GoogleFonts.poppins(
    //                           color: colors.AppColor.lightGrey,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w500)),
    //                 );
    //               } else {
    //                 return Container(
    //                   padding: const EdgeInsets.all(10),
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey[300],
    //                       borderRadius: BorderRadius.circular(20)),
    //                   child: Text(data.result!,
    //                       style: GoogleFonts.poppins(
    //                           color: colors.AppColor.tertiaryColor,
    //                           fontSize: 12,
    //                           fontWeight: FontWeight.w500)),
    //                 );
    //               }
    //             }),
    //           );
    //         },
    //       ),
    //       Text('ss')
    //     ],
    //   ),
    // ));
  }

  buildScoreDiagram() {
    LastAnalysisStats? data =
        controller.dataURLReport!.data!.attributes!.lastAnalysisStats;

    return CircularPercentIndicator(
      radius: Get.width * 0.15,
      lineWidth: 15.0,
      animation: true,
      percent: data!.malicious != 0
          ? (data.malicious! + data.suspicious!.toInt()) / 100
          : data.suspicious != 0
              ? data.suspicious! / 100
              : (data.harmless! + data.undetected!.toInt()) / 100,
      animationDuration: 1000,
      backgroundColor: colors.AppColor.lightGrey,
      center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              data.malicious != 0
                  ? (data.suspicious! + data.malicious!.toInt()).toString()
                  : data.suspicious != 0
                      ? data.suspicious.toString()
                      : (data.harmless! + data.undetected!.toInt()).toString(),
              style: GoogleFonts.poppins(
                  color: data!.malicious != 0
                      ? colors.AppColor.fail2
                      : data!.suspicious != 0
                          ? colors.AppColor.fail2
                          : colors.AppColor.success,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
            Space(1),
            Text(
              "/ 95",
              style: GoogleFonts.poppins(
                  color: colors.AppColor.subtitle2Color, fontSize: 12),
            )
          ]),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: data!.malicious != 0
          ? colors.AppColor.fail2
          : data!.suspicious != 0
              ? colors.AppColor.fail2
              : colors.AppColor.success,
    );
  }
}
