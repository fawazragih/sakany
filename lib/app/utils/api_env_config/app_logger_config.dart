import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const bool enableLog = kDebugMode;
// const bool enableLog = true;

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return enableLog;
  }
}

class MyConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var element in event.lines) {
      if (enableLog) {
        // ignore: avoid_print
        print(element);
      }
    }
  }
}

final Logger logger = Logger(
  level: kDebugMode ? Level.trace : Level.off,
  filter: MyFilter(),
  output: MyConsoleOutput(),
  printer: PrettyPrinter(
    methodCount: 4,
    colors: true,
    errorMethodCount: 10,
    printEmojis: false,
    // printTime: false,
  ),
);
