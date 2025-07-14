import 'package:app_extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:sakani/app/utils/url_launcher_manager.dart';

class GlobalHtmlViewWidget extends StatelessWidget {
  final String data;
  final Color? fillColor;
  final double? height;
  final bool showOnlyTextWidget;

  const GlobalHtmlViewWidget({
    super.key,
    required this.data,
    this.fillColor,
    this.height,
    this.showOnlyTextWidget = true,
  });

  String parseHtmlString(String? htmlString) {
    if (htmlString == null) {
      return 'no data';
    }
    final document = parse(htmlString);
    final String? parsedString =
        parse(document.body?.text).documentElement?.text;
    return parsedString?.trim() ?? 'no data';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: parseHtmlString(data).getTextDirection,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: fillColor ?? Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: showOnlyTextWidget
            ? Text(
                parseHtmlString(data),
                textAlign: TextAlign.justify,
              )
            : Html(
                data: data,
                shrinkWrap: true,
                onLinkTap: (
                  String? url,
                  Map<String, String> attributes,
                  dom.Element? element,
                  // String? url,
                  // RenderContext context,
                  // Map<String, String> attributes,
                  // dom.Element? element,
                ) {
                  if(url.isNullOrEmpty) {
                    UrlLauncherManager.openUrlLink(urlLink: Uri.encodeFull(url!));
                  }
                },
              ),
      ),
    );
  }
}
