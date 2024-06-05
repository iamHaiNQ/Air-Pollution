import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/ui/components/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectOptionImage extends StatefulWidget {
  final String? cameraTitle;
  final String? libraryTitle;
  final String? deleteTitle;
  final Function onComplete;
  final Function? onDelete;
  final bool isCropImage;

  const SelectOptionImage({
    super.key,
    this.cameraTitle,
    this.libraryTitle,
    required this.onComplete,
    this.deleteTitle,
    this.onDelete,
    this.isCropImage = false,
  });

  @override
  State<StatefulWidget> createState() => _SelectOptionImageState();
}

class _SelectOptionImageState extends State<SelectOptionImage> {
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> onOpenGallery(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        // crop image after select or take picture
        if (widget.isCropImage) {
          if (mounted) {
            Navigator.pop(context);
          }
        } else {
          widget.onComplete(pickedFile, pickedFile.readAsBytes());
        }
      }
    } catch (e) {
      if (source == ImageSource.gallery) {
        if (!context.mounted) return;
        AppSnackBar.showWarning(
          context,
          message: "Đã xảy ra lỗi khi mở tệp",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.zero,
          onTap: () => onOpenGallery(
            ImageSource.camera,
            context: context,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 16,
            ),
            child: Row(
              children: [
                const Icon(Icons.camera_alt),
                const SizedBox(width: 12),
                Text(
                  widget.cameraTitle ?? "Chụp ảnh",
                )
              ],
            ),
          ),
        ),
        const Divider(
          height: 1,
          color: AppColors.v2NeutralColor03,
        ),
        InkWell(
          borderRadius: BorderRadius.zero,
          onTap: () => onOpenGallery(
            ImageSource.gallery,
            context: context,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 16,
            ),
            child: Row(
              children: [
                const Icon(Icons.photo_library),
                const SizedBox(width: 12),
                Text(
                  widget.libraryTitle ?? "Chọn ảnh từ thư viện",
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
