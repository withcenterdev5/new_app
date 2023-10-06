import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_app/home.screen/forms/edit.form.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    UserService.instance.get(myUid!);
    // UserService.instance.documentChanges;
  }

  @override
  Widget build(BuildContext context) {
    return UserDocReady(
      builder: (user) => StreamBuilder(
        stream: UserService.instance.documentChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                userInfo(snapshot, context),
                // UserLikedByListScreen(uids: ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget userInfo(AsyncSnapshot<User?> snapshot, BuildContext context) {
    return Row(
      children: [
        UserProfileAvatar(
          user: snapshot.data!,
          radius: 30,
          upload: true,
          uploadIcon: SizedBox(
            height: 45,
            width: 45,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.cameraRetro,
                size: sizeMd,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
        const SizedBox(width: sizeSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textBuilder(context, snapshot.data!.displayName, true),
            _textBuilder(context, snapshot.data!.name, false),
            _textBuilder(context, snapshot.data!.gender, false),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const EditForm(),
            );
          },
          icon: const FaIcon(
            FontAwesomeIcons.penToSquare,
            size: sizeMd - 4,
          ),
        ),
      ],
    );
  }

  Widget _textBuilder(BuildContext context, String? label, bool isHighlight) {
    return Text(
      label ?? '',
      style: TextStyle(
        color: isHighlight ? Colors.black : Theme.of(context).shadowColor.withAlpha(150),
        fontSize: isHighlight ? sizeMd : sizeSm - 3,
      ),
    );
  }
}
