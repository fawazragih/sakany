import 'package:flutter_web_plugins/flutter_web_plugins.dart';

setPathUrlStrategy() {
  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  usePathUrlStrategy();
  // ui.platformViewRegistry.registerViewFactory('example', (_) => DivElement()..innerText = 'Hello, HTML!');
}
