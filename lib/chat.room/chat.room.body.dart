import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:new_app/page.essentials/app.bar.dart';

class ChatRoomBody extends StatefulWidget {
  const ChatRoomBody({super.key});

  @override
  State<ChatRoomBody> createState() => _ChatRoomBodyState();
}

class _ChatRoomBodyState extends State<ChatRoomBody> {
  @override
  Widget build(BuildContext context) {
    final ChatRoomListViewController controller = ChatRoomListViewController();
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        child: Column(
          children: [
            const SizedBox(height: sizeXxs),
            SizedBox(
              height: constraints.maxHeight - sizeXxl - sizeSm,
              child: StreamBuilder(
                  stream: UserService.instance.documentChanges,
                  builder: (context, snapshot) {
                    return ChatRoomListView(
                      controller: controller,
                      singleChatOnly: false,
                      itemBuilder: (context, room) => ChatRoomListTile(
                          room: room,
                          onTap: () {
                            ChatService.instance.customize.chatRoomAppBarBuilder =
                                ({room, user}) => _customAppBar(context, room);
                            controller.showChatRoom(context: context, room: room);
                          }
                          // onTap: () => controller.showChatRoom(context: context, room: room),
                          ),
                    );
                  }),
            ),
            // Container(
            //   width,
            // )
          ],
        ),
      );
    });
  }

  AppBar _customAppBar(BuildContext context, Room? room) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      elevation: 0,
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
