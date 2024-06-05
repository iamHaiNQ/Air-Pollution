import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/models/entities/notification_message_entity.dart';
import 'package:airpollution/ui/components/app_snack_bar.dart';
import 'package:airpollution/ui/pages/data_bank/data_bank_page.dart';
import 'package:airpollution/ui/pages/home/home_page.dart';
import 'package:airpollution/ui/pages/map/map_page.dart';
import 'package:airpollution/ui/pages/profile/profile_page.dart';
import 'package:airpollution/utils/logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main_cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainCubit();
      },
      child: const MainChildPage(),
    );
  }
}

class MainChildPage extends StatefulWidget {
  const MainChildPage({Key? key}) : super(key: key);

  @override
  State<MainChildPage> createState() => _MainChildPageState();
}

class _MainChildPageState extends State<MainChildPage> {
  late final MainCubit _cubit;
  int _selectedIndex = 0;
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _setupFirebaseMessage();
  }

  void _setupFirebaseMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        await buildNotificationSnackBar(message);
      }
      logger.d('RemoteMessage $message');
    });
  }

  Future<void> buildNotificationSnackBar(RemoteMessage? noti) async {
    final notification = NotificationMessageEntity.fromJson(noti?.data ?? {});

    Color? backgroundColor;
    final aqiLevel = int.parse(notification.aqiLevel ?? '0');

    if (aqiLevel == 5) {
      backgroundColor = Colors.red;
    } else if (aqiLevel == 4) {
      backgroundColor = Colors.orange;
    } else {
      backgroundColor = Colors.green;
    }

    GlobalData.instance.colorAQI = backgroundColor;

    return AppSnackBar.showInfo(
      context,
      timeDisplay: 30,
      title: noti?.notification?.title,
      message: noti?.notification?.body ?? '',
      backgroundColor: backgroundColor,
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          HomePage(),
          MapPage(),
          DataBankPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppVectors.iconMenuInactive,
              ),
              activeIcon: SvgPicture.asset(
                AppVectors.iconMenuActivated,
              ),
              label: "Menu",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppVectors.iconMapInactive,
              ),
              activeIcon: SvgPicture.asset(
                AppVectors.iconMapInactive,
                color: Colors.blue,
              ),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppVectors.iconImportInactive,
              ),
              activeIcon: SvgPicture.asset(
                AppVectors.iconImportActivated,
              ),
              label: "Data bank",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppVectors.iconMoreSquare,
              ),
              activeIcon: SvgPicture.asset(
                AppVectors.iconMoreSquareActivated,
              ),
              label: "Profile",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.colorAccentBlue,
          selectedLabelStyle: AppTextStyle.textAccentBlueS10,
          unselectedLabelStyle: AppTextStyle.blackS10.copyWith(
            color: Colors.black.withOpacity(0.72),
          ),
          iconSize: 24,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              controller.jumpToPage(index);
            });
          },
          elevation: 5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
