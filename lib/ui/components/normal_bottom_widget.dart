import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  /// Cho biết button có khả dụng không. Mặc đinh là [true]
  final bool isEnable;

  /// Hàm gọi lại
  final VoidCallback? onTap;

  /// Văn bản hiển thị
  final String text;

  ///
  final Widget? icon;

  final Widget? iconRight;

  /// Màu của văn bản. Mặc định là [White]
  final Color textColor;

  /// Kích thước của văn bản
  final double fontSize;

  /// Màu văn bản khi [isEnable] == false
  final Color? disableTextColor;

  /// Màu nền, mặc định là [vBrandColorRed]
  final Color? backgroundColor;

  /// Màu nền khi [isEnable] == false
  final Color? disableBackgroundColor;

  /// Padding theo chiều ngang và chiều dọc
  final EdgeInsetsGeometry insertPadding;

  ///
  final Decoration? decoration;

  /// Child, có mức độ hiển thị cao hơn [text]
  // final Widget? child;

  /// Kiểu hiển thị văn bản, có mức độ ưu tiên cao hơn [textColor]
  final TextStyle? textStyle;

  /// Weight của văn bản. Mặc định là [FontWeight.bold]
  final FontWeight fontWeight;

  /// Ràng buộc về bố cục
  final BoxConstraints constraints;

  /// Căn chỉnh bên trong, mặc định là null
  final Alignment? alignment;

  /// Border
  final BorderRadius? borderRadius;

  const NormalButton({
    Key? key,
    required this.text,
    this.icon,
    this.iconRight,
    this.backgroundColor = AppColors.vBlueColor,
    this.isEnable = true,
    this.onTap,
    this.insertPadding = const EdgeInsets.symmetric(
      vertical: 13.5,
      horizontal: 30,
    ),
    this.decoration,
    this.textStyle,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 16,
    this.textColor = AppColors.vWhite,
    this.constraints = const BoxConstraints.tightFor(),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.alignment,
    this.disableBackgroundColor,
    this.disableTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: alignment,
          decoration: decoration ?? _getBoxDecoration(backgroundColor),
          constraints: constraints,
          padding: insertPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: _getTextStyle(),
              ),
              if (iconRight != null) ...[
                const  SizedBox(width: 8),
                iconRight!,
              ],
            ],
          ),
        ),
        Positioned.fill(
          child: InkWell(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            onTap: () {
              if (isEnable && onTap != null) {
                FocusScope.of(context).requestFocus(FocusNode());
                onTap!();
              }
            },
          ),
        ),
      ],
    );
  }

  TextStyle _getTextStyle() {
    if (textStyle != null) {
      return textStyle!;
    }
    Color textColor;
    if (isEnable) {
      textColor = this.textColor;
    } else {
      textColor = disableTextColor ?? (this.textColor).withOpacity(0.7);
    }

    return AppTextStyle.blackS16W500.copyWith(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
    );
  }

  BoxDecoration _getBoxDecoration(Color? bgColor) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      border: isEnable
          ? Border.all(
              color: bgColor ?? AppColors.vBlueColor,
              width: 1,
            )
          : null,
    );
  }
}

class _OutlineBoxDecorationCreator {
  static BoxDecoration createOutlineBoxDecoration({
    required bool isEnable,
    Color? disableLineColor,
    Color? lineColor,
    required Color backgroundColor,
    required Color disableBackgroundColor,
    double radius = 6,
    double borderWith = 1.0,
  }) {
    Color lineColor0 = isEnable ? lineColor! : disableLineColor!;
    Color bgColor = isEnable ? backgroundColor : disableBackgroundColor;

    return BoxDecoration(
      border: Border.all(color: lineColor0, width: borderWith),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      color: bgColor,
    );
  }
}
