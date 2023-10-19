import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:gamezoning/Controller/Provider/theme_provider.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLight = ref.watch(selectedThemeProvider);
    ThemeData lightTheme =
        FlexThemeData.light(useMaterial3: true, scheme: FlexScheme.greenM3);
    ThemeData darkTheme =
        FlexThemeData.dark(useMaterial3: true, scheme: FlexScheme.greenM3);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: isLight ? lightTheme : darkTheme,
      darkTheme: darkTheme,
      routerConfig: AppRouter().router,
    );
  }
}
