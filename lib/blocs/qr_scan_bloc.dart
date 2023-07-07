import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_app/data/model/contact_model.dart';
import 'package:we_chat_app/data/model/contact_model_impl.dart';

class QRScanBloc extends ChangeNotifier {
  /// STATES
  bool isLoading = false;
  bool isDisposed = false;
  // Barcode? result;
  QRViewController? controller;
  Barcode? result;

  final ContactModel _model = ContactModelImpl();


  Future<void> callApi(Barcode qr) {
    result = qr;
    notifySafety();
    if(result?.code != null) {
      return _model.addNewContact(result!.code!);
    } else {
      return Future.error("error");
    }

  }

  // void onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     result = scanData;
  //     notifySafety();
  //   });
  //   print(result);
  // }
  //
  // void reassembleCamera() {
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   }
  //   controller!.resumeCamera();
  // }

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
