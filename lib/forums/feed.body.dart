import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';

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

// export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
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
