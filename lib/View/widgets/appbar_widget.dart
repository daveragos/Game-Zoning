import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/theme_provider.dart';

class AppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const AppBarWidget({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(selectedThemeProvider);
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
          tooltip: 'theme mode',
          onPressed: () {
            ref.read(selectedThemeProvider.notifier).setDate(!themeData);
          },
          icon: const Icon(Icons.dark_mode),
        ),
      ],
    );
  }
}
