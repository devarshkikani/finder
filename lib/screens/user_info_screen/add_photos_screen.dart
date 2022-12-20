// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dotted_border/dotted_border.dart';
import 'package:finder/constant/app_endpoints.dart';

import 'package:finder/constant/sizedbox.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/screens/user_info_screen/complete_profile_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:finder/widget/app_bar_widget.dart';
import 'package:finder/widget/elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddPhotos extends StatefulWidget {
  const AddPhotos({super.key});

  @override
  State<AddPhotos> createState() => _AddPhotosState();
}

class _AddPhotosState extends State<AddPhotos> {
  final ImagePicker picker = ImagePicker();
  List<String?> images = <String>[];

  static GetStorage box = GetStorage();
  static late UserModel userModel;
  @override
  void initState() {
    super.initState();
    userModel = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
  }

  Future<String?> getImageUrl(File file, BuildContext context) async {
    final data = dio.FormData.fromMap({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Add you're best photos here!",
                  style: boldText34.copyWith(
                    color: primary,
                    fontFamily: 'source_serif_pro',
                  ),
                ),
                height15,
                Text(
                  'The first photo in your album will be your profile photo.',
                  style: mediumText20.copyWith(
                    color: greyColor,
                  ),
                ),
                height20,
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
                            context, xFile != null ? index : null);
                      },
                      child: xFile != null
                          ? ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: xFile,
                                placeholder: (context, url) => Padding(
                                  padding: const EdgeInsets.all(70),
                                  child: Platform.isAndroid
                                      ? const CircularProgressIndicator()
                                      : const CupertinoActivityIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
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
                height15,
                Center(
                  child: Text(
                    'Add at least 2 photos to complete\nyour profile.',
                    textAlign: TextAlign.center,
                    style: regularText16.copyWith(
                      color: greyColor,
                    ),
                  ),
                ),
                height20,
                Center(
                  child: elevatedButton(
                    title: 'Continue',
                    backgroundColor: Colors.green,
                    onTap: images.length < 2
                        ? null
                        : () {
                            userModel.photos = images;
                            box.write(
                              StorageKey.currentUser,
                              userModel.toJson(),
                            );
                            Get.to(() => const CompleteProfileScreen());
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
          }
        } else {
          final String? imageUrl =
              await getImageUrl(File(croppedImage.path), context);
          if (imageUrl != null) {
            images.add(imageUrl);
          }
        }
      }
    }
    Navigator.pop(context);
    setState(() {});
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
}
