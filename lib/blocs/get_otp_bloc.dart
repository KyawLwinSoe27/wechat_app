import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/wechat_model.dart';

class GetOTPBloc extends ChangeNotifier {
  final WeChatModel _model = AuthenticationModelImpl();

  /// STATE
  bool isDisposed = false;
  int phoneNumber = 0;
  int otpCode = 0;
  bool isLoading = false;
  bool? isOTPCorrect;

  /// Events
  void onTapDone(String otp) {
    otpCode = int.parse(otp);
    notifySafety();
  }

  void onTapVerify() {
    showLoading();
    _model.getOTP().then((value) {
      if(value.otpCode == otpCode) {
        isOTPCorrect = true;
        hideLoading();
      } else {
        isOTPCorrect = false;
        hideLoading();
      }
    });
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
