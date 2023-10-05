import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:new_app/forums/feed.body.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/bottom.navbar.dart';
import 'package:new_app/forums/post/create.post.dart';
import 'package:new_app/page.essentials/floating.button.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  void initState() {
    super.initState();

    // PostService.instance.customize.showEditScreen = (context,{categoryId,post}) {};
    PostService.instance.customize.shareButtonBuilder = (post) {
      return const Icon(Icons.share);
    };

    // can not check if working, install on
    // physical phone if necessary
    PostService.instance.init(
        enableNotificationOnLike: true,
        onLike: (Post post, bool isLiked) async {
          if (!isLiked) return;
          MessagingService.instance.queue(
            title: post.title,
            body: '${my.name} liked your post',
            id: myUid,
            uids: [post.uid],
            type: NotificationType.post.name,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(text: 'Forum'),
        // leading: const LeadingButton(),
        actions: const [
          AppBarAction(),
        ],
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: const FeedBody(),
      bottomNavigationBar: const BottomNavBar(index: 0),
      floatingActionButton: CustomFloatingButton(
        context: context,
        icon: Icons.create,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const PostCreate(),
            // pageBuilder: (context, _, __) => CategoryCreateScreen(success: (category) {
            //   context.pop();
            //   alert(
            //     context: context,
            //     title: 'Category Added',
            //     message: '${category.name} has successfully added',
            //   );
            // }),
          );
        },
      ),
    );
  }
}
