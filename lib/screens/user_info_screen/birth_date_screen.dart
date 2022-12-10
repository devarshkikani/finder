import 'dart:io';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({super.key});

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;
  static DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's your date\nof birth?",
                style: boldText34.copyWith(
                  color: primary,
                  fontFamily: 'source_serif_pro',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: DatePickerWidget(
                  looping: false,
                  lastDate: DateTime.now(),
                  initialDate: DateTime(1994),
                  dateFormat: 'dd/MMMM/yyyy',
                  onChange: (DateTime newDate, _) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                  pickerTheme: DateTimePickerTheme(
                    backgroundColor: Colors.transparent,
                    itemTextStyle: regularText20,
                    dividerColor: primary,
                  ),
                ),
              ),
              selectedDate != null
                  ? Text(
                      '''Make sure ${DateTime.now().year - selectedDate!.year} is your correct age as you can't change it later''',
                      style: lightText18,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
              height20,
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    maximumSize: Size(Get.width / 2, 50),
                    disabledBackgroundColor: darkGrey,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  onPressed: selectedDate != null
                      ? () {
                          userModel.birthDate = selectedDate;
                          box.write(
                            StorageKey.currentUser,
                            userModel.toJson(),
                          );
                        }
                      : null,
                  child: Center(
                    child: Text(
                      'Continue',
                      style: mediumText16.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
