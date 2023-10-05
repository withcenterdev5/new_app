// import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:new_app/home.screen/user.profile.dart';
import 'package:new_app/page.essentials/app.bar.dart';
import 'package:new_app/page.essentials/bottom.navbar.dart';
import 'package:new_app/router/router.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/MainPage';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class MainPageBody extends StatefulWidget {
  const MainPageBody({super.key});

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const LeadingButton(),
        title: const TitleText(text: 'Profile'),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        // forceMaterialTransparency: true,
        elevation: 0,
        actions: const [
          AppBarAction(),
        ],
      ),
      body: const UserProfile(),
      bottomNavigationBar: const BottomNavBar(index: 2),
    );
  }
}
