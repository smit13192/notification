import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification/core/router/routes.dart';
import 'package:notification/firebase_options.dart';
import 'package:notification/screen/home_screen.dart';
import 'package:notification/screen/notification_screen.dart';
import 'package:notification/service/awesome_notification_service.dart';
import 'package:notification/service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AwesomeNotificationService.initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      navigatorKey: navigatorKey,
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomeScreen(),
        Routes.notification: (context) => const NotificationScreen(),
      },
    );
  }
}
