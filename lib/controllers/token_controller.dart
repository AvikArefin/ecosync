import 'package:get/get.dart';

class TokenController extends GetxController {
  final _currentToken = "".obs;

  setCurrentToken(String token) => _currentToken.value = token;
  String getCurrentToken() => _currentToken.value;
}