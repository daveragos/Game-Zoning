import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Provider/theme_provider.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const AppBarWidget({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightMode = ref.watch(themePreferenceProvider);

    return AppBar(
      title: const Center(
        child: Text(
          'G A M E   Z O N E R',
          style: TextStyle(
            color: Colors.green,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Theme Mode',
          onPressed: () {
            ref.read(themePreferenceProvider.notifier).toggleTheme();
          },
          icon: isLightMode
              ? const Icon(FontAwesomeIcons.solidMoon)
              : const Icon(FontAwesomeIcons.solidSun),
        ),
      ],
    );
  }
}
