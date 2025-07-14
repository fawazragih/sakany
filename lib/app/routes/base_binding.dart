import 'package:get/get.dart';

/// To lazyPut controller on navigation.
class BaseBinding<T> implements Bindings {
  InstanceBuilderCallback<T> controller;
  String? tag;
  BaseBinding(this.controller,{this.tag});

  @override
  void dependencies() {
    Get.lazyPut<T>(controller,tag:tag );
  }
}