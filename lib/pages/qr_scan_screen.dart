import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_app/blocs/qr_scan_bloc.dart';
import 'package:we_chat_app/resources/colors.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QRScanBloc(),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 700, child: _buildQrView(context)),
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(
                            result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Consumer<QRScanBloc>(
                    builder: (context, bloc, child) =>
                        MaterialButton(
                            child: Text("DONE"),
                            onPressed: () {
                              if (result != null) {
                                bloc.callApi(result!).then((value) =>
                                    Navigator.pop(context));
                              }
                            }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Consumer<QRScanBloc>(
      builder: (context, bloc, child) => QRView(
        key: qrKey,
        onQRViewCreated: (controller) => _onQRViewCreated(controller, bloc),
        overlay: QrScannerOverlayShape(
            borderColor: PURE_WHITE_COLOR,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 300),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller, QRScanBloc bloc) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });

  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
