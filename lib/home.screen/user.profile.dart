import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // UserService.instance.customize.
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
                    pageBuilder: (context, _, __) => Theme(
                        data: ThemeData(
                          appBarTheme: AppBarTheme(
                            color: Theme.of(context).canvasColor,
                            elevation: 0,
                            // backgroundColor: Theme.of(context).hintColor,
                          ),
                          primaryTextTheme: const TextTheme(),
                          iconButtonTheme: IconButtonThemeData(
                            style: ButtonStyle(
                              iconColor: Theme.of(context).shadowColor,
                            ),
                          ),
                        ),
                        child: const ProfileViewersListScreen()),
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
                    pageBuilder: (context, _, __) => Followers(followers: followers),
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

class Followers extends StatelessWidget {
  const Followers({
    super.key,
    required this.followers,
  });

  final List<String> followers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Followers', hasLeading: true, hasActions: false),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, i) => UserDoc(
            uid: followers[i],
            builder: (follower) {
              return ListTile(
                onTap: () => UserService.instance.showPublicProfileScreen(context: context, user: follower),
                leading: UserAvatar(
                  user: follower,
                  size: sizeXl,
                ),
                title: Text(follower.name),
                trailing: const FaIcon(FontAwesomeIcons.chevronRight),
              );
            }),
      ),
    );
  }
}
/// display category
// const Text('Categories'),
// const Expanded(
//   child: CategoryListView(),
// ),