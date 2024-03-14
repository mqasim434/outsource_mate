import 'package:flutter/material.dart';
import 'package:outsource_mate/providers/bottom_navbar_provider.dart';
import 'package:outsource_mate/providers/chat_provider.dart';
import 'package:outsource_mate/providers/nav_provider.dart';
import 'package:outsource_mate/providers/otp_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/projects_filter_widget_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/providers/signup_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/utils/router.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => SigninProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => ProjectsFilterWidgetProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        checkerboardOffscreenLayers: true,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),

        initialRoute: RouteName.signupScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
