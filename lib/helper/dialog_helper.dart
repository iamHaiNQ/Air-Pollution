import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/ui/components/normal_bottom_widget.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  /// dialog
  static showDialogConfirm(
    context, {
    String? title,
    String? message,
    String? buttonNameCancel,
    String? buttonNameConfirm,
    Function? onCancelAction,
    Function? onConfirmAction,
    double? height,
    Widget? widgetContent,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          //this right here
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title ?? "Thông báo",
                    style: AppTextStyle.blackS16W500,
                  ),
                  const SizedBox(height: 12),
                  widgetContent ??
                      Text(
                        message ?? 'Xác nhận thay đổi',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.blackS14W500.copyWith(
                          color: AppColors.v2NeutralColor075,
                        ),
                      ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: NormalButton(
                          text: buttonNameCancel ?? 'Hủy',
                          backgroundColor: AppColors.v2NeutralColor02,
                          insertPadding: const EdgeInsets.symmetric(
                            vertical: 13.5,
                          ),
                          textStyle: AppTextStyle.blackS14W500.copyWith(
                            color: AppColors.v2NeutralColor075,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            if (onCancelAction != null) {
                              onCancelAction();
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NormalButton(
                          insertPadding: const EdgeInsets.symmetric(
                            vertical: 13.5,
                          ),
                          text: buttonNameConfirm ?? 'Xác nhận',
                          textStyle: AppTextStyle.blackS14W500.copyWith(
                            color: AppColors.vWhite,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            if (onConfirmAction != null) {
                              onConfirmAction();
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showDialogView(
    context, {
    String? title,
    String? message,
    String? buttonNameConfirm,
    Function? onConfirmAction,
    double? height,
    Widget? widgetContent,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          //this right here
          child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title ?? "Thông báo",
                    style: AppTextStyle.blackS16W500,
                  ),
                  const SizedBox(height: 12),
                  widgetContent ??
                      Text(
                        message ?? 'Xác nhận thay đổi',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.blackS14W500.copyWith(
                          color: AppColors.v2NeutralColor075,
                        ),
                      ),
                  const SizedBox(height: 12),
                  NormalButton(
                    insertPadding: const EdgeInsets.symmetric(
                      vertical: 13.5,
                    ),
                    text: buttonNameConfirm ?? 'Xác nhận',
                    textStyle: AppTextStyle.blackS14W500.copyWith(
                      color: AppColors.vWhite,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      if (onConfirmAction != null) {
                        onConfirmAction();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
