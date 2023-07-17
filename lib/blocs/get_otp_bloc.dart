import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/network/notification_send.dart';

class GetOTPBloc extends ChangeNotifier {
  final AuthenticationModel _model = AuthenticationModelImpl();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final SendNotification sendNotification = SendNotificationImpl();


  /// STATE
  bool isDisposed = false;
  String? phoneNumber;
  int otpCode = 0;
  bool isLoading = false;
  bool? isOTPCorrect;

  String? deviceToken;

  /// Events

  GetOTPBloc() {
    _initializeToken();
  }

  // Asynchronous method to get the token
  Future<void> _initializeToken() async {
    // Use the "await" keyword to get the token asynchronously
    deviceToken = await firebaseMessaging.getToken();
    // Now the token is available and stored in the "token" variable
  }

  void onTapDone(String otp) {
    otpCode = int.parse(otp);
    notifySafety();
  }

  void onTapPhoneNumber(String number) {
    phoneNumber = number;
    notifySafety();
  }

  Future<void> onTapVerify() async{
    showLoading();
    await _model.getOTP().then((value) {
      if(value.otpCode == otpCode) {
        isOTPCorrect = true;
        hideLoading();
      } else {
        isOTPCorrect = false;
        hideLoading();
      }
    });
  }

  void onTapGetOTP() {
    if(phoneNumber != null) {
      sendNotification.sendNotification(deviceToken ?? "", "WeChat App Send OTP", "Your OTP Code is 1234");
    }
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
