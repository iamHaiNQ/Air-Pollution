import 'package:airpollution/commons/app_colors.dart';
import 'package:flutter/material.dart';

class NormalBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;
  final double? height;
  final String? subTitle;
  final EdgeInsets subTitlePadding;
  final Color? bgColor;
  final bool isFlexible;
  final String? actionTitle;
  final Function? onTapAction;
  final Function? onCloseAction;
  final Widget? leftButton;

  const NormalBottomSheet({
    required this.child,
    super.key,
    required this.title,
    this.height,
    this.subTitle,
    this.subTitlePadding = const EdgeInsets.only(top: 12.0),
    this.bgColor = AppColors.vWhite,
    this.isFlexible = false,
    this.actionTitle,
    this.onTapAction,
    this.onCloseAction,
    this.leftButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: isFlexible ? MainAxisSize.min : MainAxisSize.max,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(18),
                topLeft: Radius.circular(18),
              ),
            ),
            height: subTitle != null && subTitle!.isNotEmpty ? 87 : 54,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Visibility(
                          visible: subTitle != null && subTitle!.isNotEmpty,
                          child: Padding(
                            padding: subTitlePadding,
                            child: Text(
                              subTitle ?? '',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(34),
                    onTap: () {
                      Navigator.pop(context);
                      onCloseAction?.call();
                    },
                    child: const Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                ),
                leftButton ?? const SizedBox.shrink()
              ],
            ),
          ),
          Container(
            color: AppColors.v2NeutralColor03,
            height: 1,
            width: double.infinity,
          ),
          isFlexible ? Flexible(child: child) : Expanded(child: child),
        ],
      ),
    );
  }
}
