import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/simple.builders.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String followers = my.followers.toList().length.toString();

  @override
  void initState() {
    super.initState();
    UserService.instance.get(myUid!);
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
                buttonBuilder('Profile Viewers', () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, _, __) => const ProfileViewersListScreen(),
                  );
                }),
                buttonBuilder('Show Profile', () {
                  UserService.instance.showPublicProfileScreen(context: context, user: my);
                }),
                Text('Followers: $followers'),
                buttonBuilder('Followers', () {
                  List<String> followers = my.followers.toList();
                  debugPrint('${my.isAdmin}');
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, _, __) => Scaffold(
                      appBar: appBar('Followers', hasLeading: true),
                      body: ListView.builder(
                        itemCount: followers.length,
                        itemBuilder: (context, i) => UserDoc(
                            uid: followers[i],
                            builder: (follower) {
                              return ListTile(
                                leading: UserAvatar(
                                  user: follower,
                                  size: sizeXl,
                                ),
                                title: Text(follower.name),
                              );
                            }),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
/// display category
// const Text('Categories'),
// const Expanded(
//   child: CategoryListView(),
// ),