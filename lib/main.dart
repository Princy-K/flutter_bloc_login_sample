import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'modules/auth/view/auth_page.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );

  // Set white status bar with dark icons
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      // or your primary color
      statusBarIconBrightness: Brightness.dark,
      // light or dark icons
      systemNavigationBarColor: Colors.white,
      // <- App primary color
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.white));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('MAIN');
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthPage(),
    );
  }
}
