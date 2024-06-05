import 'dart:io';

import 'package:airpollution/commons/app_colors.dart';
import 'package:airpollution/commons/app_images.dart';
import 'package:airpollution/commons/app_text_styles.dart';
import 'package:airpollution/helper/dialog_helper.dart';
import 'package:airpollution/ui/components/normal_bottom_sheet.dart';
import 'package:airpollution/ui/components/select_image_widget.dart';
import 'package:airpollution/ui/components/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'data_bank_cubit.dart';

class DataBankPage extends StatelessWidget {
  const DataBankPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return DataBankCubit();
      },
      child: const DataBankChildPage(),
    );
  }
}

class DataBankChildPage extends StatefulWidget {
  const DataBankChildPage({Key? key}) : super(key: key);

  @override
  State<DataBankChildPage> createState() => _DataBankChildPageState();
}

class _DataBankChildPageState extends State<DataBankChildPage> {
  late final DataBankCubit _cubit;
  late TextEditingController contentController;
  final List<String> _dropdownItems = [
    'Không khí',
    'Nước',
    'Đất',
    'Tiếng ổn',
  ];

  final List<String> _dropdownItems2 = [
    "Nguy hại",
    "Rất xấu",
    "Xấu",
    "Kém",
    "Trung bình",
    "Tốt",
  ];

  String? _selectedItem;
  String? _selectedItem2;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    contentController = TextEditingController();
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            DialogHelper.showDialogView(
              context,
              message: "Cảm ơn bạn đã đóng góp thông tin.",
              buttonNameConfirm: "Đồng ý",
            );
          },
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.vBlueColor,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Center(
              child: Text(
                "Gửi",
                style: AppTextStyle.blackS18Bold.copyWith(
                  color: AppColors.vWhite,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: <Widget>[
            Image.asset(
              AppImages.imgEarthGreen,
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              controller: contentController,
              labelText: "Địa chỉ chi tiết",
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.v2NeutralColor04,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text('Loại ô nhiễm'),
                        value: _selectedItem,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                        items: _dropdownItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.v2NeutralColor04,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text('Mức độ ô nhiễm'),
                      value: _selectedItem2,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem2 = newValue;
                        });
                      },
                      items: _dropdownItems2
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFieldWidget.area(
              controller: contentController,
              hintText: "Mô tả",
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                const Text("Hình ảnh thực tế:"),
                const Spacer(),
                InkWell(
                  onTap: () {
                    addImage();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.v2NeutralColor06,
                      ),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Text("Chọn ảnh"),
                        SizedBox(width: 8),
                        Icon(Icons.add_a_photo_outlined),
                      ],
                    ),
                  ),
                )
              ],
            ),
            BlocBuilder<DataBankCubit, DataBankState>(
              buildWhen: (prev, current) => prev.images != current.images,
              builder: (context, state) {
                return SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.images?.length ?? 0,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                state.images![index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 19,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void addImage() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;
        return Container(
          padding: EdgeInsets.only(bottom: bottom),
          constraints: BoxConstraints(
            minHeight: 0,
            maxHeight: 200 + bottom,
          ),
          width: double.infinity,
          child: NormalBottomSheet(
            isFlexible: true,
            title: "Chọn ảnh",
            child: SelectOptionImage(
              onComplete: (file, bytes) {
                _cubit.addImage(File(file.path));
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
