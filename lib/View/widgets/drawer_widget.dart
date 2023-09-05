import 'package:flutter/material.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const DrawerWidget({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                ),
                SizedBox(height: 10),
                Text('Gamer'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              context.go(AppRouter.loginPath);
            },
          ),
        ],
      ),
    );
  }
}
