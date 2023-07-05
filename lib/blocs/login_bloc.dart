import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier {
  final AuthenticationModel _model = AuthenticationModelImpl();

  /// States
  bool isLoading = false;
  bool isDisposed = false;

  String phoneNumber = "";
  String email = "";
  String password = "";

  /// Events
  onChangePhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifySafety();
  }

  onChangeEmail(String email) {
    this.email = email;
    notifySafety();
  }

  onChangePassword(String password) {
    this.password = password;
    notifySafety();
  }

  Future onTapLogin() {
    return _model.login(email, password);
  }


  void showLoading() {
    isLoading = true;
    notifySafety();
  }

  void hideLoading() {
    isLoading = false;
    notifySafety();
  }

  void notifySafety() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}