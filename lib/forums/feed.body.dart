import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/forums/post/create.post.dart';
import 'package:new_app/home.screen/main.page.dart';

class FeedBody extends StatefulWidget {
  const FeedBody({
    super.key,
  });

  @override
  State<FeedBody> createState() => _FeedBodyState();
}

class _FeedBodyState extends State<FeedBody> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    PostService.instance.uploadFromCamera = false;
    PostService.instance.uploadFromFile = false;
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // notifications, add post / image buttons here
          Padding(
            padding: const EdgeInsets.only(left: sizeSm, right: sizeSm),
            child: Row(
              children: [
                UserAvatar(
                  user: my,
                  radius: sizeXl,
                  size: sizeXl,
                  onTap: () => context.push(MainPage.routeName),
                ),
                const SizedBox(width: sizeSm),
                const PostField(),
                const SizedBox(width: sizeXs),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.image,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PostListView(
              itemBuilder: (context, post) => PostDoc(
                post: post,
                builder: (post) {
                  return Theme(
                    data: ThemeData(
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Theme.of(context).primaryColor,
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
