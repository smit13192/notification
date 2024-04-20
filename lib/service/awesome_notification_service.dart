import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationService {
  static final _awesomNotifications = AwesomeNotifications();

  static Future<void> initializeNotification() async {
    await _awesomNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'High Important Notification',
          channelDescription: 'This channel is use for important notification',
          defaultColor: Colors.blue,
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
          criticalAlerts: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel',
          channelGroupName: 'Group 1',
        ),
      ],
      debug: true,
    );

    bool isAllowed = await _awesomNotifications.isNotificationAllowed();
    if (!isAllowed) {
      await _awesomNotifications.requestPermissionToSendNotifications();
    }
    await _awesomNotifications.setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}

  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {}

  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {}

  static Future<void> showNotification({
    required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? paylod,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButton,
    final bool schedule = false,
    final int? internal,
  }) async {
    assert(!schedule || (schedule && internal != null));
    final id = Random().nextInt(1000);
    _awesomNotifications.createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: paylod,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButton,
      schedule: schedule
          ? NotificationInterval(
              interval: internal,
              timeZone: await _awesomNotifications.getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
