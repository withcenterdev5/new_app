import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/chat.room/chat.room.body.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/bottom.navbar.dart';
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
    // ChatService.instance.customize.chatRoomAppBarBuilder =({room, user}) => User
  }

  final ChatRoomListViewController controller = ChatRoomListViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingButton(),
        title: const TitleText(text: 'Chat'),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        // forceMaterialTransparency: true,
        actions: const [
          AppBarAction(),
        ],
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: const ChatRoomBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).canvasColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => ChatRoomCreateDialog(
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
        elevation: 0,
        child: const FaIcon(
          FontAwesomeIcons.pencil,
          size: sizeMd,
        ),
      ),
    );
  }
}
