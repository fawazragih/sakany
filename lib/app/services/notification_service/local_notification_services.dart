import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../data/models/push_notification_model.dart';
import '../app_shared_data_manager.dart';

class LocalNotificationService {
  // final Logger _logger = Logger();

  // final String androidSound = 'notification_sound.wav';
  // final String iosSound = 'notification_sound.aiff';

  // LocalNotificationService._();
  //
  // static LocalNotificationService _instance;
  //
  // static LocalNotificationService get instance {
  //   flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
  //   return _instance ??= LocalNotificationService._();
  // }

  LocalNotificationService._();

  static final LocalNotificationService _instance =
      LocalNotificationService._();

  static LocalNotificationService get instance {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    return _instance;
  }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  late InitializationSettings initializationSettings;

  late NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  //region initializing method.
  initializing() async {
    //Initialisation should only be done once,and this can be done is in the
    // main function of your application. Alternatively, this can be done within
    // the first page shown in your app.
    //-------------
    //initialise the plugin. app_icon needs to be a added
    // as a drawable resource to the Android head project
    // if its in drawable you don't need @drawalbe

    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();

    //android setting init
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    //if in drawable
    // AndroidInitializationSettings('ic_launcher');

    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    //ios setting init
    DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      defaultPresentBadge: true,
      defaultPresentAlert: true,
      defaultPresentSound: true,
    );

    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    //region MacOS setting init
    DarwinInitializationSettings initializationSettingsMacOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    //pass init all platform setting to InitializationSettings
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: initializationSettingsMacOS,
    );

    // pass InitializationSettings to flutterLocalNotificationsPlugin
    await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
        ?.getNotificationAppLaunchDetails();
    // await manageIconCounter();
  }

  //endregion of initializing method.

  checkIfInitFromNotification() {
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      //  logger.d(' / / / checkIfInitFromNotification is true');
      // selectedNotificationPayload = notificationAppLaunchDetails.payload;
      // initialRoute = SecondPage.routeName;
    }
  }

  NotificationDetails _getNotificationDetailsSpecifics({int? unreadCount}) {
    //region androidNotificationDetails
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      // 'your other channel id',
      // 'your other channel name',
      // channelDescription: 'your other channel description',
      /*  channel.id,
      channel.name,
      channelDescription: channel.description,
      */
      '1123',
      'LocalNotificationChannel',
      channelDescription: 'MainChannel',
      priority: Priority.high,
      importance: Importance.max,
      channelShowBadge: true,
      playSound: true,
      onlyAlertOnce: false,
      enableVibration: true,
      enableLights: true,
      // vibrationPattern: vibrationPattern,
      // sound: RawResourceAndroidNotificationSound(androidSound.split('.').first),
      ticker: 'ticker',
      // largeIcon: iconPath != null
      //     ? FilePathAndroidBitmap(
      //         iconPath,
      //       )
      //     : null,
    );
    //endregion

    //region iosNotificationDetails
    DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: unreadCount,
      // sound: iosSound,
      // attachments: iconPath != null
      //     ? <DarwinNotificationAttachment>[
      //         DarwinNotificationAttachment(iconPath),
      //       ]
      //     : null,
    );
    //endregion

    //region macOSNotificationDetails
    DarwinNotificationDetails macOSNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      // sound: iosSound,
      badgeNumber: unreadCount,
      // attachments: iconPath != null
      //     ? <DarwinNotificationAttachment>[
      //         DarwinNotificationAttachment(iconPath),
      //       ]
      //     : null,
    );
    //endregion

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: macOSNotificationDetails,
    );

    return notificationDetails;
  }

  Future showNotification(
    RemoteMessage message,
  ) async {
    // _logger.d(message.toMap());

    /*if (pushNotification.unreadCount != 0) {
      await LocalNotificationBadgeHelper.manageIconCounter(pushNotification.unreadCount);
    } else {
      LocalNotificationBadgeHelper.removeAppBadge();
    }*/

    // logger.d('----------------------');
    // _logger.d("pushNotification : ${pushNotification.toMap()}");
    // _logger.d('----------------------');

    //region if pushNotification has icon, download it and save it to local storage
    /*String? iconPath;
    if (pushNotification.icon != null) {
      // 'https://via.placeholder.com/128x128',
      iconPath = await DownloadNotificationIcon.downloadAndSaveFile(
        pushNotification.icon!,
        Platform.isIOS || Platform.isMacOS
            ? 'notificationIcon.jpg'
            : 'notificationIcon',
      );
    }*/
    //endregion

    //region vibrationPattern
    /*final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;*/
    //endregion

    String? title, body;

    title = message.notification?.title ??
        message.data['title'] ??
        'no title provided';
    body = message.notification?.body ??
        message.data['body'] ??
        'no body provided';

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      // 'high_importance_channel', // id
      // 'High Importance Notifications', // title
      title.hashCode.toString(), // id
      body.hashCode.toString(), // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      enableVibration: true,
      enableLights: true,
      playSound: true,
      showBadge: true,
      // sound: RawResourceAndroidNotificationSound(androidSound.split('.').first),
      // vibrationPattern: vibrationPattern,
    );

    // _logger.d(iconPath);

    await flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin?.show(
      message.messageId.hashCode,
      // 123,
      title,
      body,
      _getNotificationDetailsSpecifics(
          // unreadCount: unreadCount,
          ),
      payload: json.encode(message.toMap()),
    );
  }

  Future onNotificationTap(NotificationResponse details) async {
    // bool isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    // if (isAppBadgeSupported) {
    //   FlutterAppBadger.updateBadgeCount(++badgeCount);
    // }

    if (details.payload != null) {
      var data = json.decode(details.payload!);
      // if (payload == 'create_post')  logger.d('navigate to $payload');
      AppSharedDataManager.instance.setSharedData(data);
      // navigationService.navigateTo(CreatePostViewRoute);
    }
  }

  ///..........................
  void setupNotificationClickAction(String payload) {
    //TODO byMe handle notification click action.

    /*// handle firebase and local notification clicks here

    // final data = pushNotificationModelFromJson(payload);
    final data = json.decode(payload);
    final itemId = int.tryParse(data.itemId ?? '') ?? 0;

    switch (int.tryParse(data.itemType ?? '') ?? 0) {
      case NotificationType.PRODUCT:
        Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
            arguments: ProductDetailsScreenArguments(
              id: itemId,
              name: '',
            ));
        break;

      case NotificationType.CATEGORY:
        Navigator.of(context).pushNamed(
          ProductListScreen.routeName,
          arguments: ProductListScreenArguments(
            id: itemId.toInt(),
            name: '',
            type: GetBy.CATEGORY,
          ),
        );
        break;

      case NotificationType.MANUFACTURER:
        Navigator.of(context).pushNamed(
          ProductListScreen.routeName,
          arguments: ProductListScreenArguments(
            id: itemId.toInt(),
            name: '',
            type: GetBy.MANUFACTURER,
          ),
        );
        break;

      case NotificationType.VENDOR:
        Navigator.of(context).pushNamed(ProductListScreen.routeName,
            arguments: ProductListScreenArguments(
                id: itemId.toInt(), name: '', type: GetBy.VENDOR));
        break;

      case NotificationType.ORDER:
        Navigator.of(context).pushNamed(OrderDetailsScreen.routeName,
            arguments: OrderDetailsScreenArguments(orderId: itemId));
        break;

      case NotificationType.ACCOUNT:
        Navigator.of(context).pushNamed(RegistrationScreen.routeName,
            arguments: RegistrationScreenArguments(getCustomerInfo: true));
        break;

      case NotificationType.TOPIC:
        Navigator.of(context).pushNamed(TopicScreen.routeName,
            arguments: TopicScreenArguments(topicId: itemId));
        break;

      case NotificationType.FILE_DOWNLOADED:
        if (data.body != null) {
          openDownloadedFile(data.body!);
        }
        break;
    }*/
  }
  ///..........................

  showFileDownloadNotification({String? path}) async {
    // TODO open file on notification click
    var filename = "File";

    // For iOS request permission first.
    if (!kIsWeb && Platform.isIOS) {
      await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    if (path != null && path.isNotEmpty) {
      var tokens = path.split('/');
      if (tokens.isNotEmpty) filename = tokens.last;
    }

    final payload = jsonEncode(
      PushNotificationModel(
        body: path,
        itemId: '0',
        itemType: NotificationType.FILE_DOWNLOADED,
        title: 'Title',
      ),
    );

    flutterLocalNotificationsPlugin?.show(
      0,
      "$filename downloaded",
      "",
      _getNotificationDetailsSpecifics(),
      payload: payload,
    );
  }
}

class LocalNotificationBadgeHelper {
  static manageIconCounter(int count) async {
    // bool supported = await doesPlatformSupportIconBadge();
    // if (supported) {
    //   FlutterAppBadger.updateBadgeCount(
    //     count,
    //   );
    // }
  }

  static removeAppBadge() async {
    await LocalNotificationService.flutterLocalNotificationsPlugin?.cancelAll();
    // await CacheManager.instance.changeUnreadNotificationCount(0);
    // bool supported = await doesPlatformSupportIconBadge();
    // if (supported) {
    //   FlutterAppBadger.removeBadge();
    // }
  }

  static doesPlatformSupportIconBadge() async {
    // bool appBadgeSupported = false;
    // try {
    //   appBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    //   // _logger.d('appBadgeSupported: $appBadgeSupported');
    // } on PlatformException {
    //   appBadgeSupported = false;
    // }
    // // If the widget was removed from the tree while the asynchronous platform
    // // message was in flight, we want to discard the reply rather than calling
    // // setState to update our non-existent appearance.
    // return appBadgeSupported;
  }
}
