import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/user_gender_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:finder/widget/show_banner_ads.dart';
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
      appBar: appbarWidget(),
      backgroundColor: lightBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                      itemTextStyle: regularText20.copyWith(
                        color: whiteColor,
                      ),
                      dividerColor: darkGrey,
                    ),
                  ),
                ),
                selectedDate != null
                    ? Text(
                        '''Make sure ${DateTime.now().year - selectedDate!.year} is your correct age as you can't change it later''',
                        style: lightText18.copyWith(
                          color: greyColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox(),
                height30,
                Center(
                  child: elevatedButton(
                    title: 'Continue',
                    onTap: () {
                      if (selectedDate != null) {
                        userModel.birthDate = selectedDate;
                        box.write(
                          StorageKey.currentUser,
                          userModel.toJson(),
                        );
                        Get.to(() => UserGenderScreen(
                              isEdit: false.obs,
                            ));
                      } else {
                        NetworkDio.showWarning(
                          message: 'Select your birth date first',
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const ShowBannerAds(),
    );
  }
}
