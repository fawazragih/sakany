import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:sakani_mobile_app/app/utils/api_env_config/app_logger_config.dart';
import '../app_shared_data_manager.dart';
import 'local_notification_services.dart';



@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// If you're going to use other Firebase services in the background, such as Firestore,
  /// make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  logger.d("==>Handling a background message.id: ${message.messageId}");
  // logger.d("message.data == >: ${message.data}");
  // logger.d("message.notification.title ==> : ${message.notification?.title}");
  // logger.d("message.notification.body ==> : ${message.notification?.body}");
  if (message.notification == null) {
    LocalNotificationService.instance.showNotification(message);
  }
}

class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService _instance = PushNotificationService._();

  static PushNotificationService get instance => _instance;

  ///...........................

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final LocalNotificationService _localNotification =
      LocalNotificationService.instance;

  // var _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;

  Future<String?> getToken() async {
    String? fcmToken = await _fcm.getToken(
      vapidKey: !kIsWeb
          ? null
          : 'BLoCJKjSbSZzZCiFWjpPXd_rlsEWB5sSOHBw-pVxaUVAp4wkmf8KVg87mbqXu2_i90yTdrg3k0q0RK4_Yx1hCLE',
    );
    // logger.d('fcm token is => $fcmToken');
    return fcmToken;
  }

  initialise() async {
    /// init local
    await _localNotification.initializing();

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // logger.d('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // logger.d('User granted provisional permission');
    } else {
      // logger.d('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await _fcmListenToPushNotification();

    await getToken();

    // if (hasInternetConnection) {
    //   await subscribeToAllNotification();
    // }
  }

  _fcmListenToPushNotification() async {
    //--- 1
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //--- 2
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // logger.d('==> Got a message whilst in the foreground! (onMessage)');
      // logger.d("message.data == >: ${message.data}");

      // logger
      //     .d("message.notification.title ==> : ${message.notification?.title}");
      // logger.d("message.notification.body ==> : ${message.notification?.body}");

      // logger.d(Platform.isAndroid ||
      //     (Platform.isIOS && message.notification == null));
      // await _localNotification.showNotification(message);

      if (Platform.isAndroid ||
          (Platform.isIOS && message.notification == null)) {
        await _localNotification.showNotification(message);
      }
    });
    //3 =>onOpenFromTerminatedState
    onOpenFromTerminatedState();
  }

  // subscribeToAllNotification() async {
  //   await _fcm
  //       .subscribeToTopic('topic name');
  // }

  onOpenFromTerminatedState() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      // logger.d('=====> initialMessage');
      // logger.d('=====> iniMessage.data ===>  ${initialMessage.data} //end');
      // logger.d(
      //     'initMessage.notification.title ===>  ${initialMessage.notification?.title}');
      // logger.d(
      //     'initMessage.notification.body ===>  ${initialMessage.notification?.body}');
      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      // Navigator.pushNamed(context, '/chat',
      //     arguments: ChatArguments(initialMessage));

      AppSharedDataManager.instance.setSharedData(initialMessage.data);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.d('=====> onMessageOpenedApp');
      // logger.d('=====> message.data ===>  ${message.data}');
      // logger
      //     .d('message.notification.title ===>  ${message.notification?.title}');
      // logger.d('message.notification.body ===>  ${message.notification?.body}');
      // Navigator.pushNamed(
      //   context,
      //   '/chat',
      //   arguments: ChatArguments(message),
      // );
      AppSharedDataManager.instance.setSharedData(message.data);
    });
  }

// Future<void> sendPushMessage(
//     String toFcmToken, String userName, String clubId) async {
//   final Dio _dio = new Dio();
//
//   String token =
//       'key=AAAA8BtBFGA:APA91bHZtvlGOqmfCokNZCAxtZr0uRXpMlwt1rZ_sggsGH-ODm4O9CULEeK_GsqeQPIVAe7GOScOPlDo-3BMifkEDuYYOHcYDpnXyVsUmNOkkmUVjTVlJxUwyKA4LV2D9IIawpETM4FZ';
//
//   var dataToSend = {
//     "notification": {
//       "title": "New join Request",
//       "body": "$userName request to join your club",
//     },
//     "priority": "high",
//     "data": {
//       "click_action": "FLUTTER_NOTIFICATION_CLICK",
//       "id": "1",
//       "status": "done",
//       "clubId": clubId,
//     },
//     "to": toFcmToken,
//   };
//
//   try {
//     logger.d('////////start send notification data');
//     Response response = await _dio.post("https://fcm.googleapis.com/fcm/send",
//         data: dataToSend,
//         options: Options(
//             contentType: Headers.jsonContentType,
//             headers: {'Authorization': token}));
//
//     logger.d(response.toString());
//
//     if (response.statusCode == 200) {
//       // dynamic data = response.data;
//       // var decodedJsonData = jsonDecode(jsonEncode(data));
//     }
//   } on DioError catch (error) {
//     logger.d('====> catch error in Sending Notification');
//     logger.d(error?.response?.data?.toString());
//     if (error.response.data != null) {
//       return error.response.data;
//     } else {
//       return AppStrings.unexpectedError;
//     }
//   }
// }
}
