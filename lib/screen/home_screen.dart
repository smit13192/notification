import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:notification/service/awesome_notification_service.dart';
import 'package:notification/widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            text: 'Normal Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
              );
            },
          ),
          CustomButton(
            text: 'Normal With Summary',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
                summary: 'Small summary',
              );
            },
          ),
          CustomButton(
            text: 'Progress Bar Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
                summary: 'Small summary',
                notificationLayout: NotificationLayout.ProgressBar,
              );
            },
          ),
          CustomButton(
            text: 'Message Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
                summary: 'Small summary',
                notificationLayout: NotificationLayout.Messaging,
              );
            },
          ),
          CustomButton(
            text: 'Big Picture  Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
                summary: 'Small summary',
                notificationLayout: NotificationLayout.BigPicture,
                bigPicture:
                    'https://images.unsplash.com/photo-1713528195001-80b36d6e959a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              );
            },
          ),
          CustomButton(
            text: 'Action Button Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Title of the notification',
                body: 'Body of the notification',
                summary: 'Small summary',
                actionButton: [
                  NotificationActionButton(
                    key: 'check',
                    label: 'Check it out',
                    actionType: ActionType.SilentAction,
                    color: Colors.green,
                  ),
                ],
              );
            },
          ),
          CustomButton(
            text: 'Schedule Notification',
            onPressed: () async {
              await AwesomeNotificationService.showNotification(
                title: 'Schedule Notification',
                body: 'Notification was fired after 5 second',
                schedule: true,
                internal: 5,
              );
            },
          ),
        ],
      ),
    );
  }
}
