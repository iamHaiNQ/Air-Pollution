import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/configs/global_data.dart';
import 'package:airpollution/ui/components/map_widget.dart';
import 'package:airpollution/ui/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home_cubit.dart';
import 'widgets/forecast_widget.dart'; // Import ForecastWidget

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({Key? key}) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGrayBackground,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 363,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/white-cloud-sky-background 1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 363,
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (prev, current) =>
                  prev.loadDataStatus != current.loadDataStatus,
              builder: (context, state) {
                String userName =
                    GlobalData.instance.accountEntity?.fullName ?? "Đăng nhập";

                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Welcome 👋',
                            style: AppTextStyle.blackS14W500.copyWith(
                              color: AppColors.v2TextGrayColor,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if ((GlobalData.instance.accountEntity?.fullName ?? '').isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            userName,
                            style: AppTextStyle.textOnboarding,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // liveLocation(),
                        ForecastWidget(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 12),
                            Text(
                              "Show on Map",
                              style: AppTextStyle.blackS14.copyWith(
                                color: Colors.black.withOpacity(0.72),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 160,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: MapWidget(
                                  locations: state.locations,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(
                                      21.0278,
                                      105.8342,
                                    ),
                                    zoom: 10.5,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackLevel1Color
                                    .withOpacity(0.08),
                                offset: const Offset(0, 4),
                                blurRadius: 30,
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
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                AppVectors.iconInformation,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Các mức độ chất lượng không khí",
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget liveLocation() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 108),
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      margin: const EdgeInsets.only(
        top: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Container(
        width: 32,
        height: 32,
        padding: const EdgeInsets.only(top: 4),
        child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.gps_fixed,
              color: Colors.blue,
              size: 24,
            ),
          ),
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
