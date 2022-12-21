import 'dart:io';

import 'package:finder/constant/default_images.dart';
import 'package:finder/constant/sizedbox.dart';
import 'package:finder/theme/colors.dart';
import 'package:finder/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetaisScreen extends StatefulWidget {
  const ChatDetaisScreen({super.key});

  @override
  State<ChatDetaisScreen> createState() => _ChatDetaisScreenState();
}

class _ChatDetaisScreenState extends State<ChatDetaisScreen> {
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
                topView(),
                height20,
                const Spacer(),
                chatView(),
                height5,
                Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    3,
                    10,
                    10,
                  ),
                  decoration: const BoxDecoration(
                    color: darkGrey,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
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
    );
  }

  Widget topView() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
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
            '''https://media.istockphoto.com/id/1311084168/photo/overjoyed-pretty-asian-woman-look-at-camera-with-sincere-laughter.jpg?b=1&s=170667a&w=0&k=20&c=XPuGhP9YyCWquTGT-tUFk6TwI-HZfOr1jNkehKQ17g0=''',
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
                'Debra Neugan',
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
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment:
              index.isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: index.isEven
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(20),
                      bottomRight: const Radius.circular(20),
                      topLeft: index.isEven
                          ? Radius.zero
                          : const Radius.circular(20),
                      topRight: index.isEven
                          ? const Radius.circular(20)
                          : Radius.zero,
                    ),
                    color: index.isEven ? primary.withOpacity(0.8) : darkGrey,
                  ),
                  child: Text(
                    'Good Night',
                    style: regularText14.copyWith(
                      color: index.isEven ? whiteColor : blackColor,
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
    );
  }
}
