// ignore_for_file: always_specify_types

import 'dart:io';
import 'dart:ui';
import 'package:finder/constant/default_images.dart';
import 'package:finder/screens/user_info_screen/dating_intentions_screen.dart';
import 'package:finder/screens/user_info_screen/drinking_screen.dart';
import 'package:finder/screens/user_info_screen/drugs_screen.dart';
import 'package:finder/screens/user_info_screen/ethnicity_screen.dart';
import 'package:finder/screens/user_info_screen/graduation_screen.dart';
import 'package:finder/screens/user_info_screen/language_screen.dart';
import 'package:finder/screens/user_info_screen/religion_screen.dart';
import 'package:finder/screens/user_info_screen/sexual_screen.dart';
import 'package:finder/screens/user_info_screen/smoking_screen.dart';
import 'package:finder/screens/user_info_screen/status_screen.dart';
import 'package:finder/screens/user_info_screen/user_gender_screen.dart';
import 'package:finder/screens/user_info_screen/user_height_screen.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart' as dio;
import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/divider.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/widget/input_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static GetStorage box = GetStorage();
  static late UserModel userModel;

  final ImagePicker picker = ImagePicker();
  List<String?> images = <String>[];

  RxBool firstNameEdit = false.obs;
  TextEditingController firstNameController = TextEditingController();
  RxBool lastNameEdit = false.obs;
  TextEditingController lastNameController = TextEditingController();
  RxBool emailEdit = false.obs;
  TextEditingController emailController = TextEditingController();
  RxBool dateEdit = false.obs;
  RxBool jobTitleEdit = false.obs;
  TextEditingController jobTitleController = TextEditingController();
  RxBool workPlaceEdit = false.obs;
  TextEditingController workPlaceController = TextEditingController();
  RxBool aboutYourSelfEdit = false.obs;
  TextEditingController aboutYourSelfController = TextEditingController();
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    images = userModel.photos;
    firstNameController.text = userModel.firstName;
    lastNameController.text = userModel.lastName;
    emailController.text = userModel.email ?? '';
    jobTitleController.text = userModel.jobTitle;
    workPlaceController.text = userModel.work;
    aboutYourSelfController.text = userModel.aboutYourSelf;
  }

  Future<String?> getImageUrl(File file, BuildContext context) async {
    final dio.FormData data = dio.FormData.fromMap(<String, dynamic>{
      'image': await dio.MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      )
    });
    final Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.uploadImages,
      data: data,
    );
    if (response != null) {
      return response['image'].toString();
    } else {
      return null;
    }
  }

  Future<void> updateUser({
    required BuildContext context,
  }) async {
    final Map<String, dynamic>? response = await NetworkDio.putDioHttpMethod(
      context: context,
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.registerUserDetails,
      data: userModel.toJson(),
    );
    if (response != null) {
      box.write(
        StorageKey.currentUser,
        userModel.toJson(),
      );
      setState(() {});
    }
  }

  Future<void> imageSelect(
      {required int? index,
      required ImageSource source,
      required BuildContext context}) async {
    final XFile? image = await picker.pickImage(source: source).catchError((e) {
      print('++++');
      print(e);
    });
    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image.path,
        maxWidth: 1080,
        maxHeight: 1080,
      );
      if (croppedImage != null) {
        if (index != null) {
          final String? imageUrl =
              await getImageUrl(File(croppedImage.path), context);
          if (imageUrl != null) {
            images[index] = imageUrl;
            await updateUser(context: context);
          }
        } else {
          final String? imageUrl =
              await getImageUrl(File(croppedImage.path), context);
          if (imageUrl != null) {
            images.add(imageUrl);
            await updateUser(context: context);
          }
        }
      }
    }
    Navigator.pop(context);
    setState(() {});
  }

  void modalBottomSheetMenu(BuildContext context, int? index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: 200,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                color: whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imagePickerDecoration(
                      type: 'Camera',
                      onTap: () async {
                        final PermissionStatus status =
                            await Permission.camera.request();
                        if (status.isDenied || status.isPermanentlyDenied) {
                          await openAppSettings();
                        } else {
                          await imageSelect(
                            index: index,
                            source: ImageSource.camera,
                            context: builder,
                          );
                        }
                      }),
                  Container(
                    height: 125,
                    margin: const EdgeInsets.all(20),
                    width: 1,
                    color: darkGrey,
                  ),
                  imagePickerDecoration(
                      type: 'Gallery',
                      onTap: () async {
                        final PermissionStatus status = Platform.isAndroid
                            ? await Permission.mediaLibrary.request()
                            : await Permission.photos.request();
                        if (status.isDenied || status.isPermanentlyDenied) {
                          await openAppSettings();
                        } else {
                          await imageSelect(
                            index: index,
                            source: ImageSource.gallery,
                            context: builder,
                          );
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: lightBlack,
        appBar: AppBar(
          backgroundColor: lightBlack,
          elevation: 0,
          centerTitle: false,
          title: Row(
            children: [
              Text(userModel.firstName),
              const Text(' • '),
              Text(age(userModel.birthDate.toString())),
            ],
          ),
          bottom: const TabBar(
            labelColor: primary,
            unselectedLabelColor: greyColor,
            indicatorColor: primary,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                icon: Text(
                  '      Edit      ',
                ),
              ),
              Tab(
                icon: Text('      View      '),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            editView(),
            profileTabView(),
          ],
        ),
      ),
    );
  }

  String age(String date) {
    final String birthday = date;
    final List<String> birthyear = birthday.split('-').toList();
    final int diffrtence =
        DateTime.now().year.toInt() - int.parse(birthyear[0]);
    return diffrtence.toString();
  }

  Widget editView() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: <Widget>[
              height20,
              photoEditSection(),
              height20,
              editAboutYourSelf(),
              height20,
              myVitalsView(),
              height20,
              myVirtuesView(),
              height20,
              myVicesView(),
              height20,
            ],
          ),
        ),
      ),
    );
  }

  Widget photoEditSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My photos',
          style: regularText18.copyWith(
            color: darkGrey,
          ),
        ),
        height10,
        GridView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            final String? xFile =
                (index + 1) <= images.length ? images[index] : null;
            return GestureDetector(
              onTap: () {
                modalBottomSheetMenu(
                  context,
                  xFile != null ? index : null,
                );
              },
              child: xFile != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: xFile,
                        placeholder: (BuildContext context, String url) =>
                            Padding(
                          padding: const EdgeInsets.all(70),
                          child: Platform.isAndroid
                              ? const CircularProgressIndicator()
                              : const CupertinoActivityIndicator(),
                        ),
                        errorWidget:
                            (BuildContext context, String url, error) =>
                                const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    )
                  : DottedBorder(
                      borderType: BorderType.RRect,
                      color: greyColor,
                      radius: const Radius.circular(12),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: darkGrey,
                            ),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }

  Widget imagePickerDecoration({
    required String type,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: primary,
      hoverColor: primary,
      highlightColor: primary,
      focusColor: primary,
      child: Container(
        height: 110,
        width: 110,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              type == 'Gallery'
                  ? Icons.photo_library_outlined
                  : Icons.add_a_photo_rounded,
            ),
            height15,
            Text(
              type,
              style: regularText16,
            ),
          ],
        ),
      ),
    );
  }

  Widget editAboutYourSelf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About YourSelf',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        dividers(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: aboutYourSelfEdit.value
                  ? TextFormFieldWidget(
                      controller: aboutYourSelfController,
                      autofocus: true,
                      cursorHeight: 25,
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      hintStyle: regularText20.copyWith(color: greyColor),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      style: regularText16.copyWith(
                        color: whiteColor,
                      ),
                      filledColor: Colors.transparent,
                    )
                  : Text(
                      userModel.aboutYourSelf,
                      style: regularText16.copyWith(
                        color: darkGrey,
                      ),
                    ),
            ),
            aboutYourSelfEdit.value
                ? TextButton(
                    onPressed: () async {
                      userModel.aboutYourSelf = aboutYourSelfController.text;
                      aboutYourSelfEdit.value = !aboutYourSelfEdit.value;
                      aboutYourSelfController.text = userModel.aboutYourSelf;
                      setState(() {});
                      await updateUser(context: context);
                    },
                    child: const Text('Save'),
                  )
                : TextButton(
                    onPressed: () {
                      aboutYourSelfEdit.value = !aboutYourSelfEdit.value;
                      setState(() {});
                    },
                    child: const Text('Edit'),
                  ),
          ],
        ),
      ],
    );
  }

  Widget myVitalsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Vitals',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        height10,
        dividers(10),
        textEditingView(
            title: 'First Name',
            text: userModel.firstName,
            isEdit: firstNameEdit.value,
            textEditingController: firstNameController,
            save: () async {
              userModel.firstName = firstNameController.text;
              firstNameEdit.value = !firstNameEdit.value;
              firstNameController.text = userModel.firstName;
              setState(() {});
              await updateUser(context: context);
            },
            edit: () {
              firstNameEdit.value = !firstNameEdit.value;
              setState(() {});
            }),
        dividers(10),
        textEditingView(
            title: 'Last Name',
            text: userModel.lastName,
            isEdit: lastNameEdit.value,
            textEditingController: lastNameController,
            save: () async {
              userModel.lastName = lastNameController.text;
              lastNameEdit.value = !lastNameEdit.value;
              lastNameController.text = userModel.lastName;
              setState(() {});
              await updateUser(context: context);
            },
            edit: () {
              lastNameEdit.value = !lastNameEdit.value;
              setState(() {});
            }),
        dividers(10),
        textEditingView(
            title: 'Email Address',
            text: userModel.email ?? '',
            isEdit: lastNameEdit.value,
            textEditingController: lastNameController,
            save: () async {
              userModel.email = lastNameController.text;
              lastNameEdit.value = !lastNameEdit.value;
              lastNameController.text = userModel.email ?? '';
              setState(() {});
              await updateUser(context: context);
            },
            edit: () {
              lastNameEdit.value = !lastNameEdit.value;
              setState(() {});
            }),
        dividers(10),
        birthDateView(),
        dividers(10),
        normalEditingView(
          title: 'Gender',
          text: userModel.gender,
          edit: () {
            UserGenderScreen.gender.value = userModel.gender;
            Get.to(
              () => UserGenderScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Sexuality',
          text: userModel.sexuality,
          edit: () {
            SelectSexualScreen.sexuality.value = userModel.sexuality;
            Get.to(
              () => SelectSexualScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Ethnicity',
          text: userModel.ethnicity,
          edit: () {
            EthnicityScreen.ethnicity.value = userModel.ethnicity;
            Get.to(
              () => EthnicityScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Height',
          text: userModel.height,
          edit: () {
            Get.to(
              () => UserHeightScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
      ],
    );
  }

  Widget birthDateView() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Birth Date',
                    style: regularText18.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  if (dateEdit.value)
                    TextButton(
                      onPressed: () async {
                        dateEdit.value = !dateEdit.value;
                        setState(() {});
                        await updateUser(context: context);
                      },
                      child: const Text('Save'),
                    ),
                ],
              ),
              dateEdit.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: DatePickerWidget(
                        looping: false,
                        lastDate: DateTime.now(),
                        initialDate: userModel.birthDate,
                        dateFormat: 'dd/MMMM/yyyy',
                        onChange: (DateTime newDate, _) {
                          setState(() {
                            userModel.birthDate = newDate;
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
                    )
                  : Column(
                      children: [
                        height5,
                        Text(
                          DateFormat('dd MMM yyyy')
                              .format(userModel.birthDate!),
                          style: regularText16.copyWith(
                            color: darkGrey,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        if (!dateEdit.value)
          TextButton(
            onPressed: () {
              dateEdit.value = !dateEdit.value;
              setState(() {});
            },
            child: const Text('Edit'),
          ),
      ],
    );
  }

  Widget myVirtuesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Vitals',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        height10,
        dividers(10),
        normalEditingView(
          title: 'Religion',
          text: userModel.religious,
          edit: () {
            Get.to(
              () => ReligionScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Relationship',
          text: userModel.relationType,
          edit: () {
            StatusScreen.status.value = userModel.relationType;
            Get.to(
              () => StatusScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Intentions',
          text: userModel.datingIntentions,
          edit: () {
            DatingIntentionsScreen.datingIntentions.value =
                userModel.datingIntentions;
            Get.to(
              () => DatingIntentionsScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Mother Tongue',
          text: userModel.languageSpoken,
          edit: () {
            Get.to(
              () => LanguageScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Graduation',
          text: userModel.educationLevel,
          edit: () {
            GraduationScreen.graduation.value = userModel.educationLevel;
            Get.to(
              () => GraduationScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        textEditingView(
            title: 'Job Title',
            text: userModel.jobTitle,
            isEdit: firstNameEdit.value,
            textEditingController: jobTitleController,
            save: () async {
              userModel.jobTitle = jobTitleController.text;
              jobTitleEdit.value = !jobTitleEdit.value;
              jobTitleController.text = userModel.jobTitle;
              setState(() {});
              await updateUser(context: context);
            },
            edit: () {
              jobTitleEdit.value = !jobTitleEdit.value;
              setState(() {});
            }),
        dividers(10),
        textEditingView(
            title: 'Work Place',
            text: userModel.work,
            isEdit: workPlaceEdit.value,
            textEditingController: workPlaceController,
            save: () async {
              userModel.work = workPlaceController.text;
              workPlaceEdit.value = !workPlaceEdit.value;
              workPlaceController.text = userModel.work;
              setState(() {});
              await updateUser(context: context);
            },
            edit: () {
              workPlaceEdit.value = !workPlaceEdit.value;
              setState(() {});
            }),
        dividers(10),
      ],
    );
  }

  Widget myVicesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Vices',
          style: regularText20.copyWith(
            color: primary,
          ),
        ),
        height10,
        dividers(10),
        normalEditingView(
          title: 'Drinking',
          text: userModel.drinking,
          edit: () {
            DrinkingScreen.areYouDrinking.value = userModel.drinking;
            Get.to(
              () => DrinkingScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Smoking',
          text: userModel.smoking,
          edit: () {
            SmokingScreen.areYouSmoking.value = userModel.smoking;
            Get.to(
              () => SmokingScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
        normalEditingView(
          title: 'Drugs',
          text: userModel.drugs,
          edit: () {
            DrugsScreen.areYouConsumeDrugs.value = userModel.drugs;
            Get.to(
              () => DrugsScreen(
                isEdit: true.obs,
              ),
            )?.then((value) async {
              if (value == true) {
                userModel = UserModel.fromJson(
                    box.read(StorageKey.currentUser) as Map<String, dynamic>);
                await updateUser(context: context);
              }
            });
          },
        ),
        dividers(10),
      ],
    );
  }

  Widget textEditingView({
    required String title,
    required String text,
    required bool isEdit,
    required TextEditingController textEditingController,
    required Function() save,
    required Function() edit,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: regularText18.copyWith(
                      color: whiteColor,
                    ),
                  ),
                  if (isEdit)
                    TextButton(
                      onPressed: save,
                      child: const Text('Save'),
                    ),
                ],
              ),
              height5,
              isEdit
                  ? TextFormFieldWidget(
                      controller: textEditingController,
                      style: regularText14.copyWith(
                        color: whiteColor,
                      ),
                      filledColor: Colors.transparent,
                    )
                  : Text(
                      text,
                      style: regularText16.copyWith(
                        color: darkGrey,
                      ),
                    ),
            ],
          ),
        ),
        if (!isEdit)
          TextButton(
            onPressed: edit,
            child: const Text('Edit'),
          ),
      ],
    );
  }

  Widget normalEditingView({
    required String title,
    required String text,
    required Function() edit,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: regularText18.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
              height5,
              Text(
                text,
                style: regularText16.copyWith(
                  color: darkGrey,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: edit,
          child: const Text('Edit'),
        ),
      ],
    );
  }

  Widget profileTabView() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              profileView(userModel),
              height20,
              userDetailsView(userModel),
              height20,
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userModel.photos.length,
                itemBuilder: (BuildContext context, int index) =>
                    imageView(index, userModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileView(UserModel userModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        height20,
        Text(
          '''${userModel.firstName}, ${age(userModel.birthDate.toString())}''',
          style: mediumText24.copyWith(
            color: whiteColor,
          ),
        ),
        height10,
        Container(
          height: Get.width,
          width: Get.width,
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: userModel.photos[0].toString(),
              placeholder: (BuildContext context, String url) => Padding(
                padding: const EdgeInsets.all(70),
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              ),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget imageView(int index, UserModel userModel) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: Get.width,
          width: Get.width,
          margin: EdgeInsets.only(bottom: index == 0 ? 30 : 0),
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: userModel.photos[index].toString(),
              placeholder: (BuildContext context, String url) => Padding(
                padding: const EdgeInsets.all(70),
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              ),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (index == 0)
          Positioned(
            bottom: 10,
            right: 20,
            left: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          userModel.aboutYourSelf,
                          style: regularText18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget userDetailsView(UserModel userModel) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 10,
      children: <Widget>[
        userDetailsDecoration(
          image: ethnicityIcon,
          name: userModel.ethnicity,
        ),
        userDetailsDecoration(
          image: personIcon,
          name: userModel.gender,
        ),
        userDetailsDecoration(
          image: heightIcon,
          name: userModel.height,
        ),
        userDetailsDecoration(
          image: webIcon,
          name: userModel.languageSpoken,
        ),
        userDetailsDecoration(
          image: religionIcon,
          name: userModel.religious,
        ),
        userDetailsDecoration(
          image: sexualityIcon,
          name: userModel.sexuality,
        ),
        userDetailsDecoration(
          image: personIcon,
          name: userModel.relationType,
        ),
        userDetailsDecoration(
          image: locationIcon,
          name: userModel.homeTown,
        ),
        userDetailsDecoration(
          image: workIcon,
          name: userModel.jobTitle,
        ),
        userDetailsDecoration(
          image: jobIcon,
          name: userModel.work,
        ),
        userDetailsDecoration(
          image: cigaretteIcon,
          name: userModel.smoking,
        ),
        userDetailsDecoration(
          image: drinkIcon,
          name: userModel.drinking,
        ),
        userDetailsDecoration(
          image: drugsPillsIcon,
          name: userModel.drugs,
        ),
      ],
    );
  }

  Widget userDetailsDecoration({
    required String image,
    required String name,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            image,
            height: 25,
            width: 25,
            color: whiteColor,
          ),
          width5,
          Text(
            name,
            style: regularText14.copyWith(
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
