import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:event_booking/pages/Event/add_event.dart';
import 'package:event_booking/pages/Event/attending_event/attending_event_details.dart';
import 'package:event_booking/pages/Event/attending_event/tickets.dart';
import 'package:event_booking/pages/Event/event_details.dart';
import 'package:event_booking/pages/Event/organized_event/update_user_event.dart';
import 'package:event_booking/pages/Event/organized_event/user_eventdetails.dart';
import 'package:event_booking/pages/Event/ticket_generation.dart';
import 'package:event_booking/pages/authentication/login.dart';
import 'package:event_booking/pages/authentication/register.dart';
import 'package:event_booking/pages/category/create_category.dart';
import 'package:event_booking/pages/home/homepage.dart';
import 'package:event_booking/pages/home/see_all.dart';
import 'package:event_booking/pages/home/widget/buttom_navigation.dart';
import 'package:event_booking/pages/maps/navigation.dart';
import 'package:event_booking/pages/onboarding/onboarding_screen.dart';
import 'package:event_booking/pages/profile/edit_profile/profile_edit.dart';
import 'package:event_booking/pages/settings/forgot_password.dart';
import 'package:event_booking/pages/settings/password_edit.dart';
import 'package:event_booking/pages/settings/settings.dart';
import 'package:event_booking/pages/splash/splashscreen.dart';
import 'package:event_booking/pages/stories/add_story.dart';
import 'package:event_booking/pages/stories/stories_screen.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

const String testPublicKey = 'test_public_key_fb3072f67e984603b93e915d30ebcfcd';

void main() {
  AwesomeNotifications().initialize('resource://drawable/launcher', [
    NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "basic_channel",
        channelName: "Basic notifications",
        channelDescription: "Notifications for the basic",
        defaultColor: Colors.amberAccent,
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true)
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: testPublicKey,
      enabledDebugging: true,
      builder: (context, navKey) {
        return MaterialApp(
          title: 'Evento',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
              },
            ),
          ),
          navigatorKey: navKey,
          routes: {
            '/': (context) => const SplashScreen(),
            '/onboarding': (context) => const OnBoardingScreen(),
            '/register': (context) => const SignUpScreen(),
            '/login': (context) => const LogInPage(),
            '/navigation': (context) => const ButtomNavigation(
                  key: Key('bottomNavigationBar'),
                ),
            '/home': (context) => const HomePage(),
            '/story': (context) => const StoryPage(),
            '/maps': (context) => const NavigationPage(),
            '/addEvent': (context) => const AddEventScreen(),
            '/editProfile': (context) => const ProfileEdit(),
            '/settings': (context) => const Settings(),
            '/seeAll': (context) => const SeeAll(),
            '/eventDetails': (context) => const EventDetails(),
            '/userEventDetails': (context) => const UserEventDetails(),
            '/updateEvent': (context) => const UpdateEventScreen(),
            '/addStory': (context) => const AddStoryScreen(),
            '/ticket': (context) => const TicketScreen(),
            '/tickets': (context) => const Tickets(),
            '/createcategory': (context) => const CreateCategory(),
            '/attenddetails': (context) => const AttendingEvents(),
            // '/wearhome': (context) => const Dashboard(),

            //todo: complete the below routes
            '/forgot_password': (context) => const ForgotPassword(),
            '/changepassword': (context) => const PasswordEdit(),
          },
        );
      },
    );
  }
}
