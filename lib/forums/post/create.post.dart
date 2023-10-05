import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/page.essentials/button_row.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonRow(
            label1: 'Create',
            label2: 'Cancel',
            action2: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
