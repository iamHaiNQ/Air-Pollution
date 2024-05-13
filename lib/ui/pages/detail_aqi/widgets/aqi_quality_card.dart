import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/commons/app_vectors.dart';
import 'package:airpollution/models/entities/aqi_information_entity.dart';
import 'package:airpollution/models/enums/aqi_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class AqiQualityCard extends StatelessWidget {
  final List<AQIInformation>? listAqiForecast;
  final AQIInformation? currentAQI;

  const AqiQualityCard({
    super.key,
    this.listAqiForecast,
    this.currentAQI,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  "Air Quality",
                  style: AppTextStyle.blackS20W700,
                ),
              ),
              InkWell(
                onTap: () {
                  //navigate to detail aqi level
                },
                child: SvgPicture.asset(
                  AppVectors.iconArrowDownBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: AnimatedRadialGauge(
                  duration: const Duration(seconds: 1),
                  curve: Curves.elasticOut,
                  radius: 130,
                  value: (currentAQI?.airQuality ?? 1).toDouble(),
                  axis: GaugeAxis(
                    min: 0,
                    max: 400,
                    degrees: 180,
                    progressBar: const GaugeProgressBar.rounded(
                      color: AppColors.emeraldGreenColor,
                    ),
                    style: GaugeAxisStyle(
                      background: AppColors.emeraldGreenColor.withOpacity(0.16),
                      cornerRadius: const Radius.circular(38),
                      thickness: 12,
                    ),
                    pointer: null,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "${currentAQI?.airQuality ?? ''} AQI",
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset(
                            AppVectors.iconAqiLevel1,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            currentAQI?.getAqiLevel.getInfo.title ?? '',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _buildAqiItem(
                title: "O3 (ug/m3)",
                value: "${currentAQI?.o3 ?? ''}",
              ),
              _buildAqiItem(
                title: "PM10 (ug/m3)",
                value: "${currentAQI?.pm10 ?? ''}",
              ),
              _buildAqiItem(
                title: "NO (ug/m3)",
                value: "${currentAQI?.no ?? ''}",
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              _buildAqiItem(
                title: "NO2 (ug/m3)",
                value: "${currentAQI?.no2 ?? ''}",
              ),
              _buildAqiItem(
                title: "PM1 (ug/m3)",
                value: "${currentAQI?.pm1 ?? ''}",
              ),
              _buildAqiItem(
                title: "PM2.5 (ug/m3)",
                value: "${currentAQI?.pm25 ?? ''}",
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Forecast",
            style: AppTextStyle.blackS12W500.copyWith(
              color: Colors.black.withOpacity(0.72),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            color: AppColors.colorGrayBackground,
            height: 76,
            child: ListView.separated(
              itemCount: listAqiForecast?.length ?? 0,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final item = listAqiForecast![index];
                final icon = item.getAqiLevel.getIconStatus;

                return Container(
                  // width: 36,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: const Offset(0, 2),
                          blurRadius: 8),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${item.timeOfDay}",
                        style: AppTextStyle.blackS12.copyWith(
                          color: Colors.black.withOpacity(0.72),
                          fontSize: 8,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: SvgPicture.asset(icon),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "${item.airQuality ?? ''}",
                            style: AppTextStyle.blackS16W500,
                          ),
                          Text(
                            "AQI",
                            style: AppTextStyle.blackS12.copyWith(
                              color: Colors.black.withOpacity(0.72),
                              fontSize: 8,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAqiItem({
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              AppVectors.iconStatus,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      title,
                      style: AppTextStyle.blackS10.copyWith(
                        color: Colors.black.withOpacity(0.72),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: AppTextStyle.blackS20W700,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
