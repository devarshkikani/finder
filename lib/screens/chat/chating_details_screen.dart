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
        backgroundColor: lightBlack,
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
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.fromLTRB(10, 3, 10, 10),
                    decoration: BoxDecoration(
                      color: lightBlack,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: <BoxShadow>[
                        const BoxShadow(
                          color: blackColor,
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade800,
                          offset: const Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: controller.chatController,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.newline,
                              maxLines: 11000,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              cursorHeight: 24,
                              style: regularText14.copyWith(
                                color: whiteColor,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                fillColor: lightBlack,
                                hintText: 'Type a message...',
                                hintStyle: regularText14.copyWith(
                                    color: lightGrey,
                                    fontFamily: 'source_serif_pro'),
                                contentPadding: const EdgeInsets.only(top: 8),
                                suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 24,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    if (controller
                                        .chatController.text.isNotEmpty) {
                                      controller.sendMessage(
                                        controller.chatController.text,
                                        controller.currentChatRoom.user.id
                                            .toString(),
                                      );
                                    }
                                  },
                                  child: Image.asset(
                                    sendIcon,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          width5,
                        ],
                      ),
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
        GestureDetector(
          onTap: () {
            controller.socket
              ..disconnect()
              ..dispose();
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightGrey.withOpacity(0.30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Platform.isIOS
                  ? Icons.arrow_back_ios_new_rounded
                  : Icons.arrow_back,
              color: whiteColor,
              size: 18,
            ),
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '''${controller.currentChatRoom.user.firstName} ${controller.currentChatRoom.user.lastName}''',
                  overflow: TextOverflow.ellipsis,
                  style: mediumText20.copyWith(
                    color: whiteColor,
                  ),
                ),
                Text(
                  'Online',
                  style: regularText16.copyWith(
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        // const Spacer(),
        Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: lightGrey.withOpacity(0.30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.more_vert_rounded,
            color: whiteColor,
            size: 18,
          ),
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
            shrinkWrap: true,
            reverse: true,
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.messagesList.length,
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
                            bottomLeft:
                                isMe ? Radius.zero : const Radius.circular(20),
                            bottomRight: const Radius.circular(20),
                            topLeft: const Radius.circular(20),
                            topRight:
                                isMe ? const Radius.circular(20) : Radius.zero,
                          ),
                          color: isMe ? primary.withOpacity(0.8) : lightGrey,
                        ),
                        child: Text(
                          controller.messagesList[index]['message'].toString(),
                          maxLines: 11000,
                          style: regularText14.copyWith(
                            color: isMe ? whiteColor : darkGrey,
                          ),
                        ),
                      ),
                      Text(
                        '9:21 PM',
                        style: regularText12.copyWith(
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
