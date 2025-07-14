import 'dart:math';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:sakani/app/utils/api_env_config/api_env_setter.dart';






String generateRandomDeviceId() {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  return List.generate(15, (index) => chars[r.nextInt(chars.length)]).join();
}

/*
Future<List<AvailableOption>> fetchStatesList(num countryId) async {
  GetStatesResponse response =
      await BaseRepository().getStatesByCountry(countryId.toInt());

  var stateList = response.data
          ?.map(
            (e) => AvailableOption(
              text: e.name,
              value: e.id.toString(),
            ),
          )
          .toList() ??
      [];

  // insert select
  stateList.insertAll(
    0,
    [
      AvailableOption(
        text: GlobalService().getString(Const.SELECT_STATE),
        value: '-1',
      ),
    ],
  );

  return stateList;
}
*/

// String getFormattedDate(DateTime? date, {String format = 'MM/dd/yyyy'}) {
//   try {
//     return date != null ? DateFormat(format).format(date) : '';
//   } catch (e) {
//     return '';
//   }
// }

/*String getFormattedAddress(Address? address) {
  GlobalService globalService = GlobalService();
  if (address == null) return '';
  var formattedAddress = '';

  if (address.email != null) {
    formattedAddress +=
        "${globalService.getString(Const.EMAIL)}: ${address.email}\n";
  }
  if (address.phoneNumber != null) {
    formattedAddress +=
        "${globalService.getString(Const.PHONE)}: ${address.phoneNumber}\n";
  }
  if (address.company != null) {
    formattedAddress +=
        "${globalService.getString(Const.COMPANY)}: ${address.company}\n";
  }
  if (address.address1 != null) {
    formattedAddress +=
        "${globalService.getString(Const.STREET_ADDRESS)}: ${address.address1}\n";
  }
  if (address.address2 != null) {
    formattedAddress +=
        "${globalService.getString(Const.STREET_ADDRESS_2)}: ${address.address2}\n";
  }
  if (address.zipPostalCode != null) {
    formattedAddress +=
        "${globalService.getString(Const.ZIP_CODE)}: ${address.zipPostalCode}\n";
  }
  if (address.city != null) {
    formattedAddress +=
        "${globalService.getString(Const.CITY)}: ${address.city}\n";
  }
  if (address.stateProvinceName != null) {
    formattedAddress +=
        "${globalService.getString(Const.STATE_PROVINCE)}: ${address.stateProvinceName}\n";
  }
  if (address.countryName != null) {
    formattedAddress +=
        "${globalService.getString(Const.COUNTRY)}: ${address.countryName}";
  }

  return formattedAddress.trimRight();
}*/

String? stripHtmlTags(String htmlText) {
  final document = parse(htmlText);
  final String? parsedString = parse(document.body?.text).documentElement?.text;
  return parsedString;
}

/// Load AuthToken & DeviceId from storage to memory
///
/// This method loads previously stored AuthToken & DeviceId
/// from shared preference to Global variable.
///
/// If there is no stored DeviceId, it will be generated and stored
// Future<void> prepareSessionData() async {
//   GlobalService globalService = GlobalService();
//
//   globalService.setAuthToken(await SessionData().getAuthToken());
//
//   final deviceID = await SessionData().getDeviceId();
//   if (deviceID.isEmpty) {
//     var newDeviceId = generateRandomDeviceId();
//     SessionData().setDeviceId(newDeviceId);
//     globalService.setDeviceId(newDeviceId);
//   } else {
//     globalService.setDeviceId(deviceID);
//   }
// }

bool isDarkThemeEnabled(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

// // hexSting format #FFFFFF
// Color parseColor(String hexString) {
//   try {
//     return Color(int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000);
//   } catch (e) {
//     return Colors.orange;
//   }
// }

// // hexSting format #FFFFFF
// int parseColorInt(String hexString) {
//   try {
//     return int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000;
//   } catch (e) {
//     return 0xFF121212;
//   }
// }

/*Map<int, Color> getColorSwatch(Color color) {
  return {
    50: Color.fromRGBO(color.red, color.green, color.blue, .1),
    100: Color.fromRGBO(color.red, color.green, color.blue, .2),
    200: Color.fromRGBO(color.red, color.green, color.blue, .3),
    300: Color.fromRGBO(color.red, color.green, color.blue, .4),
    400: Color.fromRGBO(color.red, color.green, color.blue, .5),
    500: Color.fromRGBO(color.red, color.green, color.blue, .6),
    600: Color.fromRGBO(color.red, color.green, color.blue, .7),
    700: Color.fromRGBO(color.red, color.green, color.blue, .8),
    800: Color.fromRGBO(color.red, color.green, color.blue, .9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1),
  };
}*/

/*ButtonStyle roundButtonStyle(BuildContext context) {
  return ButtonStyle(
    backgroundColor:
        WidgetStateProperty.all<Color>(Theme.of(context).primaryColor),
    padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.all(12.r)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
  );
}*/

/*Widget appbarGradient(BuildContext context) {
  GlobalService globalService = GlobalService();
  // logger.d('========>${_globalService.getAppLandingData().gradientEnabled}');
  // logger.d('========>${_globalService.getAppLandingData().topBarBackgroundColor}');
  //TODO: make sure of this condition
  if (globalService.getAppLandingData()?.gradientEnabled ?? false) {
    return Container(
      decoration: BoxDecoration(
        gradient: getGradient(globalService),
      ),
    );
  } else {
    //TODO: set the right color here (default color)
    return Container(
      color: Theme.of(context).primaryColor,
    );
  }
}*/

/*//TODO: set the right color here (default color)
LinearGradient getGradient(GlobalService globalService) => LinearGradient(
      colors: [
        parseColor(globalService.getAppLandingData()?.gradientStartingColor ??
            '0xFFFFFFFF'),
        parseColor(globalService.getAppLandingData()?.gradientMiddleColor ??
            '0xFFFFFFFF'),
        parseColor(globalService.getAppLandingData()?.gradientEndingColor ??
            '0xFFFFFFFF'),
      ],
      stops: const [0.30, 0.67, 1.0],
    );*/

/*
void removeFocusFromInputField(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
*/

/*Map<String, Style> htmlNoPaddingStyle(
    {Map<String, Style>? style, double? fontSize}) {
  var styleMap = {
    "body": Style(
      fontSize: FontSize(fontSize?.sp ?? 16.0.sp),
      // textAlign: TextAlign.justify,
      margin: Margins.all(0),
    ),
  };

  if (style != null) styleMap.addAll(style);

  return styleMap;
}*/

/*launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      // headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  }
}*/

/*Future<File?> saveFileToDisk(FileResponse response,
    {bool showNotification = false}) async {
  String path = '';

  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory == null) {
    // User canceled the picker
    path = selectedDirectory!;
  } else {
    return null;
  }

  */ /*if (!kIsWeb && Platform.isAndroid) {
    path = "/storage/emulated/0/Download";
  } else if (!kIsWeb && Platform.isIOS) {
    path = (await getApplicationDocumentsDirectory()).path;
  } else {
    throw Exception('Platform not supported yet');
  }*/ /*

  if (!await Directory(path).exists()) await Directory(path).create();

  // If file already exists with the same name append number
  var nameWithExt = (response.filename as String).split('.');
  File file = File('$path/${response.filename}');

  var count = 0;
  while (await file.exists() == true) {
    count++;
    file = File('$path/${nameWithExt[0]}-($count).${nameWithExt[1]}');
  }
  if (response.fileBytes != null) {
    file = await file.writeAsBytes(response.fileBytes!);

    if (showNotification) {
      NotificationUtils().showFileDownloadNotification(path: file.path);
    }

    return file;
  } else {
    throw Exception('File bytes value is null');
  }
}*/

/*Widget sectionTitleWithDivider(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          title,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
        ),
        Divider(color: Colors.grey[800])
      ],
    ),
  );
}*/

Future<bool> isRemoteVersionHigherThatLocal(
    String remoteVersion, String localVersion) async {
  final List<String> first = remoteVersion.split('.');

  if (!BuildEnvironment.instance.isGooglePlayProduction) {
    int index = localVersion.lastIndexOf('.');
    String version = localVersion.replaceRange(index, localVersion.length, '');
    localVersion = version;
  }

  final List<String> second = localVersion.split('.');
  bool isHigher = false;

  // Make the length of version string equal
  if (first.length > second.length) {
    final size = first.length - second.length;
    for (var i = 0; i < size; i++) {
      second.add('0');
    }
  } else {
    final size = second.length - first.length;
    for (var i = 0; i < size; i++) {
      first.add('0');
    }
  }

  // Compare the versions
  for (var i = 0; i < (first.length); i++) {
    isHigher = int.parse(first[i]) > int.parse(second[i].toString());
    if (int.parse(first[i]) != int.parse(second[i])) {
      break;
    }
  }
  return isHigher;
}
