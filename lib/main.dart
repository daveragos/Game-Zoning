import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/theme_provider.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //widget binding initialize
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    child: MyApp(
      prefs: prefs,
    ),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key, required prefs}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(themePreferenceProvider);

    final lightTheme =
        FlexThemeData.light(useMaterial3: true, scheme: FlexScheme.greenM3);
    final darkTheme =
        FlexThemeData.dark(useMaterial3: true, scheme: FlexScheme.greenM3);
    final currentTheme = isLightTheme ? lightTheme : darkTheme;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: currentTheme,
      darkTheme: darkTheme,
      routerConfig: AppRouter().router,
    );
  }
}
