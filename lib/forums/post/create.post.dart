import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/page.essentials/button_row.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final title = TextEditingController();
  final content = TextEditingController();
  // final title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(),
          const TextField(),
          TextFormField(
            initialValue: 'this is initialValue',
            decoration: const InputDecoration(),
          ),
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
