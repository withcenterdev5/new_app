import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_app/main.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).shadowColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: -1,
      ),
    );
  }
}

class AppBarAction extends StatelessWidget {
  const AppBarAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        top: 10,
        bottom: 10,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).hintColor.withAlpha(80),
          minimumSize: const Size.fromWidth(8),
          elevation: 0,
        ),
        onPressed: () {
          UserService.instance.signOut();
          context.push(LoginPage.routeName);
        },
        child: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class LeadingButton extends StatelessWidget {
  const LeadingButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.chevronLeft,
        color: Theme.of(context).shadowColor,
      ),
      onPressed: () => context.pop(),
    );
  }
}
