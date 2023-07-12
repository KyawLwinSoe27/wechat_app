import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_app/data/model/authentication_model.dart';
import 'package:we_chat_app/data/model/authentication_model_impl.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/model/contact_model_impl.dart';

import '../data/vos/user_vo.dart';

class QRScanBloc extends ChangeNotifier {
  /// STATES
  bool isLoading = false;
  bool isDisposed = false;
  // Barcode? result;
  QRViewController? controller;
  Barcode? result;
  UserVO? makeFriendToUser;

  final ContactModel _model = ContactModelImpl();
  final AuthenticationModel authenticationModel = AuthenticationModelImpl();


  Future<void> addNewFriend(String? userId) async {
    if(userId != null){
      isLoading = true;
      notifySafety();
      _model.addNewContact(result!.code!).then((value) => isLoading = false);
    }
  }

  Future<bool> onQRViewCreated(QRViewController controller, QRScanBloc bloc,BuildContext context) async{
    this.controller = controller;
    notifySafety();

    final completer = Completer<bool>();

    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      controller.pauseCamera();
      isLoading = true;
      notifySafety();

      makeFriendToUser = await authenticationModel.getCurrentUserInfoById(result?.code ?? "").first;
      await _model.addNewContact(result!.code!);

      isLoading = false;
      notifySafety();

      completer.complete(true);
    });

    return completer.future.then((value) {
      if (value) {
        Navigator.pop(context); // Replace 'context' with the appropriate context
      }
      return value;
    });
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
