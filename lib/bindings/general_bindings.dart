import 'package:get/get.dart';
import 'package:wallet_view/utils/network/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
