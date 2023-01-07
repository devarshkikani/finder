import 'dart:io';

import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/screens/chat/chat_screen_controller.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetaisScreen extends GetView<ChatScreenController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.socket
          ..disconnect()
          ..dispose();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  height10,
                  topView(),
                  height20,
                  chatView(),
                  height5,
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                    decoration: const BoxDecoration(
                      color: darkGrey,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: controller.chatController,
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.newline,
                            maxLines: 10,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              isDense: true,
                              contentPadding: const EdgeInsets.only(top: 8),
                              border: InputBorder.none,
                              suffixIconConstraints: const BoxConstraints(
                                maxHeight: 26,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  controller.sendMessage(
                                    controller.chatController.text,
                                    controller.currentChatRoom.user.id
                                        .toString(),
                                  );
                                },
                                child: Image.asset(
                                  sendIcon,
                                ),
                              ),
                            ),
                          ),
                        ),
                        width5,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topView() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            controller.socket
              ..disconnect()
              ..dispose();
            Get.back();
          },
          padding: EdgeInsets.zero,
          icon: Icon(
            Platform.isIOS
                ? Icons.arrow_back_ios_new_rounded
                : Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        width10,
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            controller.currentChatRoom.user.photos![0].toString(),
            fit: BoxFit.cover,
            height: 40,
            width: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '''${controller.currentChatRoom.user.firstName} ${controller.currentChatRoom.user.lastName}''',
                style: mediumText20.copyWith(
                  color: whiteColor,
                ),
              ),
              Text(
                'Online',
                style: regularText16.copyWith(
                  color: darkGrey,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.more_vert_rounded,
          color: whiteColor,
        ),
        width15,
      ],
    );
  }

  Widget chatView() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Obx(
          () => ListView.builder(
            itemCount: controller.messagesList.length,
            shrinkWrap: true,
            controller: controller.scrollController,
            padding: const EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              final bool isMe = controller.messagesList[index]['senderId'] !=
                  controller.currentUser.id;
              return Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: Get.width / 1.5,
                        ),
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: const Radius.circular(20),
                            bottomRight: const Radius.circular(20),
                            topLeft:
                                isMe ? Radius.zero : const Radius.circular(20),
                            topRight:
                                isMe ? const Radius.circular(20) : Radius.zero,
                          ),
                          color: isMe ? primary.withOpacity(0.8) : darkGrey,
                        ),
                        child: Text(
                          controller.messagesList[index]['message'].toString(),
                          maxLines: 11000,
                          style: regularText14.copyWith(
                            color: isMe ? whiteColor : blackColor,
                          ),
                        ),
                      ),
                      Text(
                        '9:21 PM',
                        style: regularText14.copyWith(
                          color: darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
