import 'package:get/get.dart';

// [
// {
// "id": 3,
// "name": "System Admin",
// "description": "safsd",
// "permissions": [
// 1,
// 2,
// 3
// ]
// },
// {
// "id": 4,
// "name": "Landfill Manager",
// "description": "asd",
// "permissions": [
// 3
// ]
// },
// {
// "id": 5,
// "name": "STS Manager",
// "description": "asd",
// "permissions": [
// 1,
// 2
// ]
// }
// ]

class RoleController extends GetxController {
  final _role = 0.obs;

  set(int role) => _role.value = role;
  get() => _role.value;
}