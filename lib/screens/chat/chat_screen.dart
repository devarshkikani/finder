import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:finder/constant/divider.dart';
import 'package:finder/models/chat_room.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/chat/chat_screen_controller.dart';
import 'package:finder/screens/chat/chating_details_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenController>(
        init: ChatScreenController(),
        builder: (ChatScreenController controller) {
          return Scaffold(
            backgroundColor: lightBlack,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  height10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Message's",
                      style: mediumText20.copyWith(
                        color: whiteColor,
                      ),
                    ),
                  ),
                  dividers(10),
                  height10,
                  Expanded(
                    child: controller.roomsList.isEmpty
                        ? Center(
                            child: Text(
                              'There is no messgae yet.',
                              style: mediumText18,
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: controller.getRoomsFunction,
                            color: whiteColor,
                            triggerMode: RefreshIndicatorTriggerMode.onEdge,
                            backgroundColor: success,
                            child: ListView.builder(
                              itemCount: controller.roomsList.length,
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              shrinkWrap: false,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext ctx, int index) {
                                final ChatRoom chatRoomDetails =
                                    ChatRoom.fromJson(
                                        controller.roomsList[index]
                                            as Map<String, dynamic>);
                                return Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () async {
                                        controller.currentChatRoom =
                                            chatRoomDetails;
                                        await controller.getMessages(context);
                                        await controller.initSocket(controller
                                            .currentChatRoom.user.id
                                            .toString());
                                        Get.to(() => ChatDetaisScreen())
                                            ?.then((_) {
                                          controller.getRoomsFunction();
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        color: Colors.transparent,
                                        child: designListTile(chatRoomDetails),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: dividers(
                                        10,
                                        color: greyColor.withOpacity(0.1),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget designListTile(ChatRoom chatRoomDetails) {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            chatRoomDetails.user.photos![0].toString(),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '''${chatRoomDetails.user.firstName} ${chatRoomDetails.user.lastName}''',
                    style: mediumText14.copyWith(
                      color: whiteColor,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (1 == 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: primary, shape: BoxShape.circle),
                      child: Text(
                        '3',
                        style: regularText12.copyWith(color: whiteColor),
                      ),
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'plan is going to suffer',
                    style: regularText14.copyWith(
                      color: darkGrey,
                    ),
                  ),
                  Text(
                    '5:45 PM',
                    style: regularText12.copyWith(
                      color: lightGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
