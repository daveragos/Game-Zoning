import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDrawerWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const EmployeeDrawerWidget({Key? key})
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
                  child: Icon(FontAwesomeIcons.user),
                ),
                SizedBox(height: 10),
                Text('E M P L O Y E E',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Column(
            children: [
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('P R O F I L E'),
                    onTap: () {
                      context.push(AppRouter.profilePath);
                    },
                  ),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.plus),
                    title: const Text('C O U N T E R'),
                    onTap: () {
                      context.push(AppRouter.counterPath);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('L O G O U T'),
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  context.go(AppRouter.loginPath);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
