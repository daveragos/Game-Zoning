import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:gamezoning/approuter.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData lightTheme =
        FlexThemeData.light(useMaterial3: true, scheme: FlexScheme.greenM3);

    ThemeData darkTheme =
        FlexThemeData.dark(useMaterial3: true, scheme: FlexScheme.deepOrangeM3);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: AppRouter().router,
    );
  }
}
