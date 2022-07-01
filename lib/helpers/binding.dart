
import 'package:get/get.dart';

import '../view_model/session_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionViewModel());
  }
}
