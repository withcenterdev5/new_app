import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/bottom.navbar.dart';
import 'package:new_app/page.essentials/floating.button.dart';
import 'package:new_app/router/router.dart';

class ChatRoom extends StatefulWidget {
  static const String routeName = '/ChatRoom';
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70),
        useMaterial3: true,
      ),
    );
  }
}

class CustomChatRoom extends StatefulWidget {
  const CustomChatRoom({super.key});

  @override
  State<CustomChatRoom> createState() => _CustomChatRoomState();
}

class _CustomChatRoomState extends State<CustomChatRoom> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FireFlutterService.instance.init(context: router.routerDelegate.navigatorKey.currentContext!);
    });
    // ChatService.instance.customize.showChatRoom = ({, })
  }

  final ChatRoomListViewController controller = ChatRoomListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Chats'),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: ChatRoomListView(
        controller: controller,
        singleChatOnly: false,
        itemBuilder: (context, room) => ChatRoomListTile(
          room: room,
          onTap: () {
            ChatService.instance.customize.chatRoomAppBarBuilder = ({room, user}) => customAppBar(context, room);
            controller.showChatRoom(context: context, room: room);
          },
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            pageBuilder: (context, _, __) => ChatRoomCreateDialog(
              success: (room) {
                context.pop();
                if (context.mounted) {
                  controller.showChatRoom(
                    context: context,
                    room: room,
                  );
                }
              },
              cancel: () => context.pop(),
            ),
          );
        },
        icon: FontAwesomeIcons.plus,
        context: context,
      ),
    );
  }

  AppBar customAppBar(BuildContext context, Room? room) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.onBackground,
      // elevation: 0,
      forceMaterialTransparency: true,
      leading: const LeadingButton(),
      title: room!.isGroupChat
          ? Text(
              room.name,
              style: TextStyle(
                color: Theme.of(context).shadowColor,
              ),
            )
          : UserDoc(
              builder: (user) => Text(
                user.name,
                style: TextStyle(
                  color: Theme.of(context).shadowColor,
                ),
              ),
              uid: otherUserUid(room.users),
              live: false,
            ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).shadowColor,
          ),
          onPressed: () async {
            return ChatService.instance.openChatRoomMenuDialog(context: context, room: room);
          },
        ),
      ],
    );
  }
}
