// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:outsource_mate/models/project_model.dart';
import 'package:outsource_mate/utils/routes_names.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/ai_chat_room.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/chat_screen.dart';
import 'package:outsource_mate/views/dashboard/chat_screen/inbox_screen.dart';
import 'package:outsource_mate/views/dashboard/dashboard.dart';
import 'package:outsource_mate/views/dashboard/more_screen/more_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/profile_screen.dart';
import 'package:outsource_mate/views/dashboard/more_screen/team_screen.dart';
import 'package:outsource_mate/views/dashboard/notifications_screen.dart';
import 'package:outsource_mate/views/dashboard/projects_screen.dart';
import 'package:outsource_mate/views/intro_screen/intro_screen.dart';
import 'package:outsource_mate/views/project_screens/create_project_screen.dart';
import 'package:outsource_mate/views/project_screens/project_details.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/new_password_screen.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/number_input_screen.dart';
import 'package:outsource_mate/views/registration_screens/forgot_screens/otp_input_screen.dart';
import 'package:outsource_mate/views/registration_screens/signin_screen.dart';
import 'package:outsource_mate/views/registration_screens/signup_screen.dart';
import 'package:outsource_mate/views/reviews/add_review_screen.dart';
import 'package:outsource_mate/views/reviews/reviews_screen.dart';
import 'package:outsource_mate/views/splash_screen/splash_screen.dart';

// ingore_for_file: prefer_ _ ructors
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case RouteName.introScreen:
        return MaterialPageRoute(
          builder: (_) => IntroScreen(),
        );

      case RouteName.signupScreen:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );

      case RouteName.signinScreen:
        return MaterialPageRoute(
          builder: (_) => SigninScreen(),
        );

      case RouteName.dashboard:
        return MaterialPageRoute(
          builder: (_) => Dashboard(),
        );

      case RouteName.projectsScreen:
        return MaterialPageRoute(
          builder: (_) => ProjectsScreen(),
        );

      case RouteName.addProjectScreen:
        return MaterialPageRoute(
          builder: (_) => AddProjectScreen(),
        );

      case RouteName.chatScreen:
        Map<String, dynamic> data = arguments as Map<String, dynamic>;
        dynamic otherUser = data['otherUser'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(otherUser: otherUser),
        );

      case RouteName.inboxScreen:
        return MaterialPageRoute(
          builder: (_) => InboxScreen(),
        );

      case RouteName.moreScreen:
        return MaterialPageRoute(
          builder: (_) => MoreScreen(),
        );

      case RouteName.teamScreen:
        return MaterialPageRoute(
          builder: (_) => TeamScreen(),
        );

      case RouteName.profileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case RouteName.numberInputScreen:
        return MaterialPageRoute(
          builder: (_) => NumberInputScreen(),
        );

      case RouteName.otpInputScreen:
        return MaterialPageRoute(
          builder: (_) => OtpInputScreen(),
        );

      case RouteName.newPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => NewPasswordScreen(),
        );

      case RouteName.aiChatRoom:
        return MaterialPageRoute(
          builder: (_) => AiChatRoom(),
        );
      case RouteName.addReviewScreen:
        Map<String, dynamic> data = arguments as Map<String, dynamic>;
        String projectId = data['projectId'];
        return MaterialPageRoute(
          builder: (_) => AddReviewScreen(
            projectId: projectId,
          ),
        );
      case RouteName.reviewsScreen:
        return MaterialPageRoute(
          builder: (_) => ReviewsScreen(),
        );

      case RouteName.projectDetailsScreen:
        Map<String, dynamic> data = arguments as Map<String, dynamic>;
        ProjectModel project = data['project'] as ProjectModel;
        return MaterialPageRoute(
          builder: (_) => ProjectDetailsScreen(
            project: project,
          ),
        );

      case RouteName.notifications:
        return MaterialPageRoute(
          builder: (_) => NotificationsScreen(),
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
