import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/models/chat_room.dart';
import 'package:finder/screens/chat/chat_screen_controller.dart';
import 'package:finder/screens/chat/chating_details_screen.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: <Widget>[
          Image.asset(
            nightSky,
            fit: BoxFit.cover,
            height: Get.height,
            width: Get.width,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                height10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Message's (12)",
                    style: mediumText20.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
                height20,
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          whiteColor,
                          whiteColor.withOpacity(0.2)
                        ],
                        begin: const FractionalOffset(1, 0.9),
                        end: const FractionalOffset(3, -3),
                        stops: const <double>[0, 2],
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.roomsList.length,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 1,
                            color: darkGrey,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final ChatRoom chatRoomDetails = ChatRoom.fromJson(
                              controller.roomsList[index]
                                  as Map<String, dynamic>);
                          return GestureDetector(
                            onTap: () async {
                              controller.currentChatRoom = chatRoomDetails;
                              await controller.getMessages(context);
                              await controller.initSocket(controller
                                  .currentChatRoom.user.id
                                  .toString());
                              Get.to(() => ChatDetaisScreen());
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              color: Colors.transparent,
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      chatRoomDetails.user.photos![0]
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                  width10,
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '''${chatRoomDetails.user.firstName} ${chatRoomDetails.user.lastName}''',
                                              style: regularText14,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: primary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                '3',
                                                style: regularText12.copyWith(
                                                  color: whiteColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'plan is going to suffer',
                                              style: regularText14.copyWith(
                                                color: greyColor,
                                              ),
                                            ),
                                            Text(
                                              '5:45 PM',
                                              style: regularText12.copyWith(
                                                color: greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
