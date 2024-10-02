
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:waste_track/Utils/colors/app_colors.dart';

///nylon serial number scanning through qr code

class QRScanner extends StatefulWidget {
  QRScanner({Key? key,}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  bool canPop = false;
  @override
  Widget build(BuildContext context) {
    String? resultData = result?.code;
    if(resultData != null && resultData.contains("serialNumber=")){
      // debugPrint("serial number scanned");
      Future.delayed(Duration.zero,(){
        // debugPrint("serial number scanned future");
        Navigator.pop(context, resultData.split("serialNumber=").last);
      });
      // Navigator.pop(context);
    }
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 400.0;
    return WillPopScope(
      onWillPop: ()async {
        String? resultData = result?.code;
        if(result != null){
          if(resultData != null && resultData.contains("serialNumber=")){
            Navigator.pop(context,resultData.split("serialNumber=").last);
            return false;
          }
          return true;
        }
        return false;
      },

      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(
                    borderColor: AppColor.green,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea),
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                    'Barcode Type: ${describeIdentity(result!.format)}\nData: ${result!.code}')
                    : Text('Scanning....'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState((){
        result = scanData;
      });

      String? resultData = result?.code;
      if(resultData != null && resultData.contains("serialNumber=")){
        //     Future.delayed(Duration.zero,(){
        //   Navigator.pop(context, resultData.split("serialNumber=").last);
        // });
        // controller.stopCamera();
        controller.dispose();
        // Navigator.pop(context);
      }
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