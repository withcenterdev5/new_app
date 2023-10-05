import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/page.essentials/button_row.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  // final User? user;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final displayName = TextEditingController();
  final name = TextEditingController();
  final gender = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserService.instance.get(myUid ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    displayName.dispose();
    name.dispose();
    gender.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserDocReady(
      builder: (user) {
        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          alignment: Alignment.center,
          child: LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: SizedBox(
                height: constraints.maxHeight / 3 - 14,
                width: 400,
                child: Column(
                  children: [
                    _textFieldBuilder('Display Name', displayName),
                    _textFieldBuilder('Name', name),
                    _textFieldBuilder('Gender', gender),
                    ButtonRow(
                      label1: 'Update',
                      action1: () async {
                        await my
                            .update(
                          displayName: displayName.text,
                          name: name.text,
                          gender: gender.text,
                        )
                            .then((value) {
                          // debugPrint('gumana');
                          context.pop();
                          toast(
                            backgroundColor: Theme.of(context).indicatorColor,
                            title: 'Profile Updated',
                            message: 'Profile has been updated successfully',
                          );
                        });
                        await my.updateComplete(true);
                      },
                      label2: 'Cancel',
                      action2: () => context.pop(),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _textFieldBuilder(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            gapPadding: 13,
          ),
          label: Text(label),
        ),
      ),
    );
  }
}
