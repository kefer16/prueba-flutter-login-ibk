import 'package:flutter_prueba_ibk/services/login.service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var isLoading = false.obs;
  var errorMessage = '';

  final LoginRepository repository = LoginRepository();

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }

  Future<String> login({required String dni, required String password}) async {
    errorMessage = '';
    try {
      showLoading();
      var response = await repository.postLogin(dni, password);
      hideLoading();
      if (response == false) {
        errorMessage = 'Login failed. Please check your credentials.';
        loginProcess.value = false;
        return errorMessage;
      } else if (response == true) {
        loginProcess.value = true;
        return errorMessage;
      } else {
        errorMessage = 'Unexpected response from the server.';
        loginProcess.value = false;
        return errorMessage;
      }
    } catch (e) {
      loginProcess(false);
      errorMessage = 'An error occurred while trying to log in.';
    }

    return errorMessage;
  }
}
