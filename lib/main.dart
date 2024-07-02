import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:outsource_mate/providers/bottom_navbar_provider.dart';
import 'package:outsource_mate/providers/chat_provider.dart';
import 'package:outsource_mate/providers/client_provider.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:outsource_mate/providers/custom_timer_provider.dart';
import 'package:outsource_mate/providers/freelancersProvider.dart';
import 'package:outsource_mate/providers/notifications_provider.dart';
import 'package:outsource_mate/providers/otp_provider.dart';
import 'package:outsource_mate/providers/profile_provider.dart';
import 'package:outsource_mate/providers/project_provider.dart';
import 'package:outsource_mate/providers/projects_filter_widget_provider.dart';
import 'package:outsource_mate/providers/signin_provider.dart';
import 'package:outsource_mate/providers/signup_provider.dart';
import 'package:outsource_mate/providers/employee_provider.dart';
import 'package:outsource_mate/providers/user_provider.dart';
import 'package:outsource_mate/res/components/switch_button_widget.dart';
import 'package:outsource_mate/utils/consts.dart';
import 'package:outsource_mate/utils/router.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: GEMINI_API_KEY);
  Stripe.publishableKey = STRIPER_PUBLISH_KEY;
  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  // await dotenv.load(fileName: ".env");
  // requestNotificationPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseMessaging.onBackgroundMessage
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message also contains a notification');
    }
  });
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
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
        ChangeNotifierProvider(create: (_) => SwitchButtonProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => FreelancersProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CustomTimerProvider()),
        ChangeNotifierProvider(create: (_) => NotificationsProvider()),
      ],
      child: FeatureDiscovery(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          checkerboardOffscreenLayers: true,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          builder: EasyLoading.init(),
          initialRoute: RouteName.splashScreen,
          // home: IntroScreen(),
          onGenerateRoute: Routes.generateRoute,
        ),
      ),
    );
  }
}
