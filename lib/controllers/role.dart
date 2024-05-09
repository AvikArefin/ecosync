import 'package:get/get.dart';

class RoleController extends GetxController {
  final _role = 0.obs;

  set(int role) => _role.value = role;
  get() => _role.value;
}