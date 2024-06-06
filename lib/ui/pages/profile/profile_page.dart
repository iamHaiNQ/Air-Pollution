import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_images.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/services/share_preferences_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ProfileCubit();
      },
      child: const ProfileChildPage(),
    );
  }
}

class ProfileChildPage extends StatefulWidget {
  const ProfileChildPage({Key? key}) : super(key: key);

  @override
  State<ProfileChildPage> createState() => _ProfileChildPageState();
}

class _ProfileChildPageState extends State<ProfileChildPage> {
  late final ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 290,
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 188,
                  child: Image.asset(
                    AppImages.imgBackgroundProfile,
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        // color: AppColors.vBlueColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 96,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.grayColor,
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: <Widget>[
                  _buildItem(
                    icon: AppVectors.iconProfile,
                    title: "Profile",
                  ),
                  _buildItem(
                    icon: AppVectors.iconSavedLocation,
                    title: "Saved Locaiton",
                  ),
                  _buildItem(
                    icon: AppVectors.iconFAQ,
                    title: "FAQ",
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.grayColor,
                    margin: const EdgeInsets.only(
                      top: 8,
                      bottom: 16,
                    ),
                  ),
                  _buildItem(
                    icon: AppVectors.iconSetting,
                    title: "Settings",
                  ),
                  _buildItem(
                    icon: AppVectors.iconAboutUs,
                    title: "About Us",
                  ),
                  _buildItem(
                    icon: AppVectors.iconAboutUs,
                    title: "Contact Us",
                  ),
                  _buildItem(
                      icon: AppVectors.iconLogout,
                      title: "Logout",
                      onTap: () {
                        SharedPreferencesStorage.removeUser();
                      }),
                  _buildItem(
                      icon: AppVectors.iconLogout,
                      title: "Copy Token",
                      onTap: () async {
                        final content = GlobalData.instance.deviceToken ?? '';
                        await Clipboard.setData(
                          ClipboardData(
                            text: content,
                          ),
                        );
                      }),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        AppVectors.iconLogo,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Air AQ",
                            style: AppTextStyle.blackS20W700,
                          ),
                          Text(
                            "Version: v1.0",
                            style: AppTextStyle.blackS12,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String icon,
    required String title,
    Function? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackLevel1Color.withOpacity(0.08),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(icon),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.blackS16W500.copyWith(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            SvgPicture.asset(
              AppVectors.iconArrowRight,
            ),
          ],
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
