import 'package:flutter/material.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/chat_screen.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/inbox_screen.dart';
import 'package:outsource_mate/views/dashboard/dashboard.dart';
import 'package:outsource_mate/views/dashboard/more_screen/more_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/profile_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/team_screen.dart';
import 'package:outsource_mate/views/dashboard/projects_screen.dart';
import 'package:outsource_mate/views/intro_screen/intro_screen.dart';
import 'package:outsource_mate/views/project_screens/project_details.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/new_password_screen.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/number_input_screen.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/otp_input_screen.dart';
import 'package:outsource_mate/views/registration_screens/signin_screen.dart';
import 'package:outsource_mate/views/registration_screens/signup_screen.dart';
import 'package:outsource_mate/views/splash_screen/splash_screen.dart';
// ingore_for_file: prefer_const_constructors
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

        case RouteName.introScreen:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
        );

      case RouteName.signupScreen:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );

      case RouteName.signinScreen:
        return MaterialPageRoute(
          builder: (_) => SigninScreen(),
        );

      case RouteName.introScreen:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
        );

      case RouteName.dashboard:
        return MaterialPageRoute(
          builder: (_) => const Dashboard(),
        );

      case RouteName.projectsScreen:
        return MaterialPageRoute(
          builder: (_) => ProjectsScreen(),
        );

      case RouteName.chatScreen:
        Map<String, dynamic> data = arguments as Map<String, dynamic>;
        dynamic otherUser = data['otherUser'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(otherUser: otherUser),
        );

      case RouteName.inboxScreen:
        return MaterialPageRoute(
          builder: (_) => const InboxScreen(),
        );

      case RouteName.moreScreen:
        return MaterialPageRoute(
          builder: (_) => const MoreScreen(),
        );

      case RouteName.teamScreen:
        return MaterialPageRoute(
          builder: (_) => const TeamScreen(),
        );

      case RouteName.profileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case RouteName.numberInputScreen:
        return MaterialPageRoute(
          builder: (_) => const NumberInputScreen(),
        );

      case RouteName.otpInputScreen:
        return MaterialPageRoute(
          builder: (_) => OtpInputScreen(),
        );

      case RouteName.newPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => const NewPasswordScreen(),
        );

        case RouteName.projectDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProjectDetailsScreen(),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          );
        });
    }
  }
}