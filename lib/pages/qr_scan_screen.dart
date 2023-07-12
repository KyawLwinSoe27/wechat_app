import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_app/blocs/qr_scan_bloc.dart';
import 'package:we_chat_app/pages/contacts_screen.dart';
import 'package:we_chat_app/resources/colors.dart';

import '../widgets/LoadingWidget.dart';

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
        body: Selector<QRScanBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) {
            return Stack(
              children: [
                Column(
                  children: <Widget>[
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: _buildQrView(context)),
                  ],
                ),
                Visibility(
                  visible: isLoading,
                  child: Container(
                    color: Colors.black12,
                    child: const Center(
                      child: LoadingWidget(),
                    ),
                  ),
                )
              ],
            );
          },
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
        onQRViewCreated: (controller) async {
          await bloc.onQRViewCreated(controller, bloc, context);
        },
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
