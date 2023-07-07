import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanBloc extends ChangeNotifier {
  /// STATES
  Barcode? result;
}