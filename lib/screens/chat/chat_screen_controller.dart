// ignore_for_file: always_specify_types

import 'package:finder/constant/app_endpoints.dart';
import 'package:finder/constant/storage_key.dart';
import 'package:finder/models/chat_room.dart';
import 'package:finder/models/user_model.dart';
import 'package:finder/utils/network_dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChatScreenController extends GetxController {
  late io.Socket socket;
  late UserModel currentUser;
  late ChatRoom currentChatRoom;
  RxBool isLoading = true.obs;
  GetStorage box = GetStorage();
  ScrollController scrollController = ScrollController();
  RxList<dynamic> roomsList = <dynamic>[].obs;
  RxList<dynamic> messagesList = <dynamic>[].obs;
  TextEditingController chatController = TextEditingController();
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'navigator');

  @override
  void onInit() {
    super.onInit();
    currentUser = UserModel.fromJson(
        box.read(StorageKey.currentUser) as Map<String, dynamic>);
    getRoomsFunction();
  }

  @override
  void dispose() {
    socket
      ..disconnect()
      ..dispose();
    super.dispose();
  }

  Future<void> initSocket(String id) async {
    socket = io.io(ApiEndPoints.apiEndPoint, <String, dynamic>{
      'autoConnect': false,
      'transports': <String>['websocket'],
    });
    socket
      ..connect()
      ..onConnect((_) {})
      ..on('receive_message', (data) {
        // scrollController.animateTo(
        //   scrollController.position.minScrollExtent,
        //   duration: const Duration(seconds: 1),
        //   curve: Curves.fastOutSlowIn,
        // );
        messagesList.insert(0, data);
      })
      // ..onDisconnect((_) => print('Connection Disconnection'))
      // ..onConnectError((err) => print(err))
      // ..onError((err) => print(err))
      ..emit('join_room',
          <String, dynamic>{'roomId': currentChatRoom.id, 'userId': id});
  }

  Future<void> getRoomsFunction() async {
    final Map<String, dynamic>? resposnse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint + ApiEndPoints.getRooms,
      context: navigatorKey.currentContext,
    );
    if (resposnse != null) {
      roomsList.value = resposnse['data'] as List<dynamic>;
      isLoading.value = false;
    }
  }

  Future<void> getMessages(BuildContext context) async {
    final Map<String, dynamic>? resposnse = await NetworkDio.getDioHttpMethod(
      url: ApiEndPoints.apiEndPoint +
          ApiEndPoints.getMessage +
          currentChatRoom.id.toString(),
      context: context,
    );
    if (resposnse != null) {
      messagesList.value = resposnse['data'] as List<dynamic>;
    }
  }

  void sendMessage(String message, String receiverId) {
    if (message.isEmpty) {
      return;
    } else {
      final Map<String, dynamic> messageMap = <String, dynamic>{
        'roomId': currentChatRoom.id,
        'message': message,
        'senderId': currentUser.id,
        'receiverId': receiverId
      };
      socket.emit('send_message', messageMap);
      chatController.clear();
    }
  }
}
