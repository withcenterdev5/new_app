import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/bottom.navbar.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
      // key: _scaffoldKey,
      appBar: AppBar(
        title: const TitleText(text: 'Forum'),
        leading: const LeadingButton(),
        actions: const [
          AppBarAction(),
        ],
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: const FeedBody(),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }
}

class FeedBody extends StatelessWidget {
  const FeedBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // notifications, add post / image buttons here
          SizedBox(
            height: constraints.maxHeight,
            child: PostListView(
              itemBuilder: (context, post) => PostDoc(
                post: post,
                builder: (post) {
                  return Theme(
                    data: ThemeData(
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.blue,
                          elevation: 0,
                          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    child: PostCard(
                      post: post,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
