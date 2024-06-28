import 'package:cipherkey/presentation/Screens/security-tools/password_generator_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cipherkey/utils/colors.dart' as colors;
import 'package:hive/hive.dart';
import '../../widget/appbar.dart';
import 'realtime_breacher_info_screen.dart';
import 'url_scanner_screen.dart';

class SecurityMenuToolsScreen extends StatefulWidget {
  const SecurityMenuToolsScreen({super.key});

  @override
  State<SecurityMenuToolsScreen> createState() =>
      _SecurityMenuToolsScreenState();
}

class _SecurityMenuToolsScreenState extends State<SecurityMenuToolsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.AppColor.primaryColor,
        elevation: 0.5,
        title: Text(
          "Security Tools",
          style: GoogleFonts.poppins(
              color: colors.AppColor.secondaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: colors.AppColor.secondaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(50),
          ),
          indicatorPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          isScrollable: true,
          tabs: const [
            Tab(
              text: 'Password Generator',
            ),
            Tab(text: 'URL Scanner'),
            Tab(text: 'Realtime Breaches Info'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const PasswordGeneratorScreen(),
          UrlScannerScreen(),
          const RealtimeBreacherInfo(),
        ],
      ),
    );
  }
}
