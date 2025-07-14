
//
// class PushNotification {
//   String? title;
//   String? body;
//   String? icon;
//   String? src;
//   String? fileId;
//   int unreadCount;
//
//   PushNotification({
//     this.title,
//     this.body,
//     this.icon,
//     this.fileId,
//     this.src,
//     this.unreadCount = 1,
//   });
//
//   factory PushNotification.fromRemoteMessage(RemoteMessage remoteMessage) {
//     String? title, body;
//     if (remoteMessage.notification?.title != null &&
//         remoteMessage.notification?.body != null) {
//       title = remoteMessage.notification!.title;
//       body = remoteMessage.notification!.body;
//     }
//
//     Map<dynamic, dynamic> data = remoteMessage.data;
//
//     return PushNotification(
//       title: title ?? data['title'],
//       body: body ?? data['body'],
//       icon: data['icon'],
//       fileId: data['fileId'],
//       src: data['src'],
//       unreadCount: data['unreadCount']?.toString().valueTypeToInt ??
//           1,
//     );
//   }
//
//   // factory PushNotification.fromMap(Map<String, dynamic> map) {
//   //   return PushNotification(
//   //     title: map['title'],
//   //     body: map['body'],
//   //     icon: map['icon'],
//   //     unreadCount: map['unreadCount']?.toString().valueTypeToInt ?? 1,
//   //   );
//   // }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'body': body,
//       'icon': icon,
//       'unreadCount': unreadCount,
//       'fileId': fileId,
//       'src': src,
//     };
//   }
// }
